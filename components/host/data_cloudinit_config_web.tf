data "cloudinit_config" "host" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = templatefile(
      "${path.module}/files/cloud-config.yaml.tmpl",
      {
        ARTIFACT_BUCKET = data.terraform_remote_state.ci.outputs.tfaps_codepipeline_s3_bucket_id
        CSI             = local.csi
        WEB_PORT        = var.web_port
        # JIRA_SSM_PARAMETER_NAME = var.jira_ssm_parameter_name
      }
    )
  }
}
