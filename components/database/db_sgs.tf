module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.csi}-sg"
  description = "Postgres DB SG"
  vpc_id      = data.aws_vpc.selected.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = local.private_subnet_cidrs
    }
  ]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-sg"
    },
  )
}
