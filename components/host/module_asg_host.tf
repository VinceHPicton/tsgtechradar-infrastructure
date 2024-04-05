module "asg_host" {
  for_each = var.hosts
  source   = "terraform-aws-modules/autoscaling/aws"
  version  = "7.3.1"

  # Autoscaling group
  name = "${local.csi}-${each.value.name}"

  min_size                  = each.value.asg_min_size
  max_size                  = each.value.asg_max_size
  desired_capacity          = each.value.asg_min_size
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = data.aws_subnets.nat.ids

  initial_lifecycle_hooks = []

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      # checkpoint_delay       = 600
      # checkpoint_percentages = [35, 70, 100]
      # instance_warmup        = 300
      min_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = local.csi
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.keypair.key_name
  #   user_data         = base64encode(data.cloudinit_config.web.rendered)
  security_groups   = [module.sg_host[each.value.name].security_group_id]
  ebs_optimized     = true
  enable_monitoring = true

  # This will ensure imdsv2 is enabled, required, and a single hop which is aws security
  # best practices
  # See https://docs.aws.amazon.com/securityhub/latest/userguide/autoscaling-controls.html#autoscaling-4
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  # Autoscaling group traffic source attachment
  create_traffic_source_attachment = true
  traffic_source_identifier        = module.alb_host[each.value.name].target_groups["asg_host"].arn
  traffic_source_type              = "elbv2"

  # Autoscaling group schedule
  # Autoscaling policy

  # IAM Role / Instance Profile
  create_iam_instance_profile = false
  iam_instance_profile_name   = aws_iam_instance_profile.host.name

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-${each.value.name}"
    },
  )
}
