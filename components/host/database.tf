resource "aws_db_subnet_group" "private" {
  name       = "${local.csi}-dbsubnetgroup"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "${local.csi}-dbsubnetgroup"
  }
}

module "database" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.5.4"

  identifier = "${local.csi}-db"

  engine               = "postgres"
  engine_version       = "15"
  family               = "postgres15"
  major_engine_version = 15

  instance_class    = var.database_config.db_instance_type
  allocated_storage = var.database_config.db_allocated_storage

  db_name  = "postgres"
  username = "postgres"
  port     = "5432"

  create_db_parameter_group = true
  parameter_group_name      = "${local.csi}-parameter-group"

  parameters = [
    {
      name  = "rds.force_ssl"
      value = "0"
    }
  ]

  db_parameter_group_tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-parameter-group"
    },
  )

  manage_master_user_password_rotation              = true
  master_user_password_rotate_immediately           = false
  master_user_password_rotation_schedule_expression = "rate(15 days)"

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false
  snapshot_identifier     = var.database_config.db_snapshot_id

  vpc_security_group_ids = [module.database_sg.security_group_id]

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.private.name

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-db"
    },
  )
}
