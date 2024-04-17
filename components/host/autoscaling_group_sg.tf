module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.csi}-asg-sg"
  description = "${local.csi} TSG Technology Radar Web ASG"
  vpc_id      = data.aws_vpc.selected.id

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = var.web_port
      to_port                  = var.web_port
      protocol                 = "tcp"
      description              = "HTTP (${var.web_port}) traffic from ALB SG"
      source_security_group_id = module.alb_sg.security_group_id
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-asg-sg"
    },
  )
}
