resource "aws_iam_policy" "s3_uplaod" {
  name        = "${local.csi}-s3-upload"
  description = "Permissions to Upload Object to S3"
  policy      = data.aws_iam_policy_document.s3_upload.json

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-s3-upload"
    },
  )
}

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

resource "aws_iam_role_policy_attachment" "s3_upload" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.s3_uplaod.arn
}
