module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  enable_deletion_protection = true

  name    = "${local.csi}-alb"
  vpc_id  = data.aws_vpc.selected.id
  subnets = data.aws_subnets.public.ids

  create_security_group = false
  security_groups       = [module.alb_sg.security_group_id]

  listeners = {
    ex_http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "asg_host"
      }
    }
  }

  target_groups = {
    asg_host = {
      protocol                          = "HTTP"
      port                              = var.web_port
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true

      # There's nothing to attach here in this definition.
      # The attachment happens in the alb_host module
      create_attachment = false
    }
  }

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-alb"
    }
  )
}
