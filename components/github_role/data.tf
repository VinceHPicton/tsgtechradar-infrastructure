data "aws_iam_openid_connect_provider" "github" {
  arn = var.github_oidc_arn
}

data "aws_ecr_repository" "frontend" {
  name = "tsgtechradarfrontend"
}

data "aws_ecr_repository" "backend" {
  name = "tsgtechradarbackend"
}

data "aws_secretsmanager_secret" "backend" {
  name = "backend_git_commit_sha"
}

data "aws_secretsmanager_secret" "frontend" {
  name = "frontend_git_commit_sha"
}