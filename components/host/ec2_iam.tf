resource "aws_iam_instance_profile" "host" {
  name = "${local.csi}-profile"
  path = "/ec2/"
  role = aws_iam_role.host.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ec2_access" {
  statement {
    sid    = "SecretsManager"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      module.database.db_instance_master_user_secret_arn
    ]
  }
  statement {
    sid    = "KMSDecrypt"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      data.aws_kms_key.secrets_kms.arn,
      data.aws_kms_key.artefacts_kms.arn
    ]
  }
  statement {
    sid    = "Logs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "*"
    ]
  }
  statement {
    sid    = "S3Artefacts"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListObjects"
    ]

    resources = [
      "${data.aws_s3_bucket.artefacts.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_access" {
  name        = "${local.csi}-ec2-access"
  description = "EC2 Instance Profile Permissions"
  policy      = data.aws_iam_policy_document.ec2_access.json

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-ec2-access"
    },
  )
}

resource "aws_iam_role" "host" {
  name        = "${local.csi}-role"
  description = "TSG Technology Radar Web ASG"

  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-host"
    },
  )
}

resource "aws_iam_role_policy_attachment" "ec2_access" {
  role       = aws_iam_role.host.name
  policy_arn = aws_iam_policy.ec2_access.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.host.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
