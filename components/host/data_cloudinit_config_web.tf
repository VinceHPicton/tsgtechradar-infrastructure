data "cloudinit_config" "host" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = templatefile(
      "${path.module}/files/cloud-config.yaml.tmpl",
      {
        ARTIFACT_BUCKET = var.artefact_bucket
      }
    )
  }
}
