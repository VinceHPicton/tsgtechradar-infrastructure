data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "al2023-ami-*-x86_64",
    ]
  }
}

data "cloudinit_config" "host" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = templatefile(
      "${path.module}/files/cloud-config.yaml.tmpl",
      {
        ENVIRONMENT             = var.environment
        DB_HOSTNAME             = module.database.db_instance_address
        DB_SECRET_ARN           = module.database.db_instance_master_user_secret_arn
        ACCOUNT_NUMBER           = var.aws_account_id
        BACKEND_GIT_COMMIT_SHA_SECRET_ARN           = aws_secretsmanager_secret.backend_git_commit_sha.arn
        FRONTEND_GIT_COMMIT_SHA_SECRET_ARN           = aws_secretsmanager_secret.frontend_git_commit_sha.arn
        AWS_REGION           = var.region
      }
    )
  }
}