output "tags" {
  description = "List of tags to assign to all resources"
  value       = local.default_tags
}

output "vpc" {
  description = "VPC in use"
  value       = data.aws_vpc.selected.id
}

output "public_subnets" {
  description = "Public Subnets"
  value       = data.aws_subnets.public.ids
}

output "nat_subnets" {
  description = "NAT Subnets"
  value       = data.aws_subnets.private.ids
}
