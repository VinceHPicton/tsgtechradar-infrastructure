output "tags" {
  description = "List of tags to assign to all resources"
  value       = local.default_tags
}

output "database_hostname" {
  description = "Endpoint of the DBs"
  value = [
    for db in module.rds_db : db.db_instance_endpoint
  ]
}
