module "database_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.csi}-database-sg"
  description = "${local.csi} Postgres DB SG"
  vpc_id      = data.aws_vpc.selected.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = local.nat_subnet_cidrs
    }
  ]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-database-sg"
    },
  )
}
