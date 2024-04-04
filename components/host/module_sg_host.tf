module "sg_host" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.csi}-host"
  description = "TSG Technology Radar Web ASG"
  vpc_id      = data.aws_vpc.selected.id

  computed_ingress_with_source_security_group_id = [
    # {
    #   rule                     = "http-80-tcp"
    #   source_security_group_id = module.alb_host.security_group_id
    # },
    {
      from_port                = var.web_port
      to_port                  = var.web_port
      protocol                 = "tcp"
      description              = "HTTP (${var.web_port}) traffic from ALB SG"
      source_security_group_id = module.alb_host.security_group_id
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-host"
    },
  )
}
