resource "aws_db_subnet_group" "private" {
  name       = "${local.csi}-dbsubnetgroup"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "My DB subnet group"
  }
}

module "rds_db" {
  for_each = var.hosts
  source   = "terraform-aws-modules/rds/aws"
  version  = "6.5.4"

  identifier = "${local.csi}-${each.value.name}"

  engine               = "postgres"
  engine_version       = "15"
  family               = "postgres15"
  major_engine_version = 15

  instance_class    = each.value.db_instance_type
  allocated_storage = each.value.db_allocated_storage

  db_name  = "postgres"
  username = "postgres"
  port     = "5432"

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
  snapshot_identifier     = each.value.db_snapshot_id

  vpc_security_group_ids = [module.security_group.security_group_id]

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.private.name

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-${each.value.name}"
    },
  )
}
