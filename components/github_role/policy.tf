data "aws_iam_policy_document" "s3_upload" {
  #checkov:skip=CKV_AWS_111:Need to allow root user to write access
  statement {
    sid = "S3Upload"

    actions = [
      "s3:PutObject"
    ]

    effect = "Allow"

    resources = [
      "${data.aws_s3_bucket.artefacts.arn}/*"
    ]
  }

  statement {
    sid    = "KMS"
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:GenerateDataKey"
    ]

    resources = [
      data.aws_kms_key.artefacts_kms.arn
    ]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:bjss/tsgtechradar-backend:*",
        "repo:bjss/tsgtechradar:*"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}
