output "role" {
  description = "Name of Github Deployment Role"
  value       = aws_iam_role.github.name
}
