output "tags" {
  description = "List of tags to assign to all resources"
  value       = local.default_tags
}

output "vpc" {
  description = "VPC in use"
  value       = data.aws_vpc.selected.id
}

output "subnets" {
  description = "Public Subnets"
  value       = data.aws_subnets.public.ids
}
