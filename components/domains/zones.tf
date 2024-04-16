resource "aws_route53_zone" "top_level" {
  name = var.domain_name

  tags = merge(
    local.default_tags,
    {
      "Domain" = var.domain_name
    }
  )
}

resource "aws_route53_zone" "dev_subdomain" {
  provider = aws.dev
  name     = "dev.${var.domain_name}"

  tags = merge(
    local.default_tags,
    {
      "Domain" = "dev.${var.domain_name}"
    }
  )
}

resource "aws_route53_zone" "stable_subdomain" {
  provider = aws.dev
  name     = "stable.${var.domain_name}"

  tags = merge(
    local.default_tags,
    {
      "Domain" = "stable.${var.domain_name}"
    }
  )
}
