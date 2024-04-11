resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name_prefix = "${local.csi}-kp"
  public_key      = tls_private_key.key.public_key_openssh
  tags = merge(
    local.default_tags,
    { "Name" : "${local.csi}-kp" }
  )
}

resource "aws_kms_key" "secrets" {
  description = "CMK for Secrets Manager ${var.environment}"
  policy      = data.aws_iam_policy_document.secrets_kms.json
}

resource "aws_kms_alias" "secrets" {
  name          = "alias/${local.csi}"
  target_key_id = aws_kms_key.secrets.key_id
}

resource "aws_secretsmanager_secret" "secret_key" {
  name_prefix = local.csi
  description = "Key Pair for Host EC2 instances"
  kms_key_id  = aws_kms_alias.secrets.id
  tags = merge(
    local.default_tags,
    { "Name" : local.csi }
  )
}

resource "aws_secretsmanager_secret_version" "secret_key_value" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = tls_private_key.key.private_key_pem
}
