output "tags" {
  description = "List of tags to assign to all resources"
  value       = local.default_tags
}

output "database_hostname" {
  description = "Endpoint of the DB"
  value       = module.rds_db.db_instance_endpoint
}
