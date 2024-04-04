module "alb_host" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  enable_deletion_protection = true

  name    = "${local.csi}-host"
  vpc_id  = data.aws_vpc.selected.id
  subnets = data.aws_subnets.public.ids

  # Security Group
  security_group_ingress_rules = {
    # all_http = {
    #   from_port   = 80
    #   to_port     = 80
    #   ip_protocol = "tcp"
    #   description = "HTTP web traffic"
    #   cidr_ipv4   = "0.0.0.0/0"
    # }
    bjss_corporate_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic from BJSS Corporate"
      cidr_ipv4   = "148.253.134.213/32"
    }
    bjss_guest_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic from BJSS Guest Wifi"
      cidr_ipv4   = "150.143.113.206/32"
    }
    bjss_vpn_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic from BJSS VPN"
      cidr_ipv4   = "148.253.134.212/32"
    }
    steve_mead_at_home_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic from Steve Mead at home"
      cidr_ipv4   = "5.80.54.206/32"
    }
    # all_https = {
    #   from_port   = 443
    #   to_port     = 443
    #   ip_protocol = "tcp"
    #   description = "HTTPS web traffic"
    #   cidr_ipv4   = "0.0.0.0/0"
    # }
  }

  security_group_egress_rules = {
    vpc_cidr = {
      ip_protocol = "-1"
      cidr_ipv4   = data.aws_vpc.selected.cidr_block
    }
  }

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
      # The attachment happens in the asg_host module
      create_attachment = false
    }
  }

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-host"
    },
  )
}
