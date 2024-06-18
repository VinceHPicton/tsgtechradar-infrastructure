

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
  role       = aws_iam_role.host.name
  policy_arn = aws_iam_policy.secret_manager_read_write.arn
}

data "aws_iam_policy_document" "secret_manager_read_write" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:*"
    ]

    resources = [
      aws_secretsmanager_secret.frontend_git_commit_sha.arn,
      aws_secretsmanager_secret.backend_git_commit_sha.arn,
    ]
  }
}
