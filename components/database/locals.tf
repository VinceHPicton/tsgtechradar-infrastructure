locals {
  csi = replace(
    format(
      "%s-%s-%s",
      var.project,
      var.environment,
      var.component,
    ),
    "_",
    "",
  )

  default_tags = merge(
    var.default_tags,
    {
      Project     = var.project
      Environment = var.environment
      Component   = var.component
      Group       = var.group
      Name        = local.csi
      service     = var.component
      env         = var.environment
    },
  )

  private_subnet_cidrs = join(",", [for s in data.aws_subnet.private : s.cidr_block])
}
