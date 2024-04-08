output "tags" {
  description = "List of tags to assign to all resources"
  value       = local.default_tags
}

output "test_local" {
  description = "View output of local private_subnet_cidrs"
  value       = local.private_subnet_cidrs
}
