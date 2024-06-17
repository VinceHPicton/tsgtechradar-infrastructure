
resource "aws_iam_role" "github" {
  name        = local.csi
  description = "GitHub Deployment Role"

  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    local.default_tags,
    {
      "Name" = local.csi
    },
  )
}