resource "aws_route53_record" "dev_subdomain_delegation" {
  zone_id = aws_route53_zone.top_level.zone_id
  name    = "dev.${var.domain_name}"
  type    = "NS"
  ttl     = 172800
  records = aws_route53_zone.dev_subdomain.name_servers
}

resource "aws_route53_record" "stable_subdomain_delegation" {
  zone_id = aws_route53_zone.top_level.zone_id
  name    = "stable.${var.domain_name}"
  type    = "NS"
  ttl     = 172800
  records = aws_route53_zone.stable_subdomain.name_servers
}
