module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.csi}-alb-sg"
  description = "${local.csi} TSG Technology Radar ALB SG"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = ["148.253.134.213/32", "150.143.113.206/32", "148.253.134.212/32"]
  ingress_rules       = ["https-443-tcp"]

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-alb-sg"
    },
  )
}
