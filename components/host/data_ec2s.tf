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
        ARTIFACT_BUCKET         = var.artefact_bucket
        ENVIRONMENT             = var.environment
        DB_HOSTNAME             = module.database.db_instance_endpoint
        DB_SECRET_ARN           = module.database.db_instance_master_user_secret_arn
        WEB_PORT                = var.web_port
        JIRA_SSM_PARAMETER_NAME = var.jira_ssm_parameter_name
        HOST_SECRET_NAME        = "${local.csi}-credentials"
      }
    )
  }
}
