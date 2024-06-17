resource "aws_iam_policy" "ecr_push" {
  name        = "${local.csi}-ecr-push"
  description = "ECR Push Permissions"
  policy      = data.aws_iam_policy_document.ecr_push.json

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-ecr-push"
    },
  )
}

resource "aws_iam_role_policy_attachment" "attach_ecr_push" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.ecr_push.arn
}

data "aws_iam_policy_document" "ecr_push" {
  statement {
    effect = "Allow"

    actions = [
      "ecr:*"
    ]

    resources = [
      data.aws_ecr_repository.frontend.arn,
      data.aws_ecr_repository.backend.arn,
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*",
    ]
  }
}