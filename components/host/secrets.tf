resource "aws_secretsmanager_secret" "frontend_git_commit_sha" {
  name = "frontend_git_commit_sha"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "backend_git_commit_sha" {
  name = "backend_git_commit_sha"
  recovery_window_in_days = 0
}
