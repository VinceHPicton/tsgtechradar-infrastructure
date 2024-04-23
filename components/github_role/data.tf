data "aws_s3_bucket" "artefacts" {
  bucket = var.artefact_bucket
}

data "aws_kms_key" "artefacts_kms" {
  key_id = var.artefact_bucket_key_id
}

data "aws_iam_openid_connect_provider" "github" {
  arn = var.github_oidc_arn
}
