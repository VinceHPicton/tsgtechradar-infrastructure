

resource "aws_iam_policy" "secret_manager_read_write" {
  name        = "${local.csi}-secrets-read-write"
  description = "AWS Secrets read write Permissions"
  policy      = data.aws_iam_policy_document.secret_manager_read_write.json

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-secrets-read-write"
    },
  )
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_read_write" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.secret_manager_read_write.arn
}

data "aws_iam_policy_document" "secret_manager_read_write" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:*"
    ]

    resources = [
      data.aws_secretsmanager_secret.frontend.arn,
      data.aws_secretsmanager_secret.backend.arn,
    ]
  }
}