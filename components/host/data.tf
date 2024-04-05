data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Type = "public"
  }
}

data "aws_subnets" "nat" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "${var.project}-${var.environment}-core-nat*"
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "al2023-ami-*-x86_64",
    ]
  }
}

data "aws_iam_policy_document" "secrets_kms" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ViaService"
      values   = ["secretsmanager.eu-west-2.amazonaws.com"]
    }

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.aws_account_id]
    }
  }

  statement {
    actions = [
      "kms:GenerateDataKey*"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ViaService"
      values   = ["secretsmanager.eu-west-2.amazonaws.com"]
    }

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.aws_account_id]
    }
  }

  statement {
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "kms:RevokeGrant"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
    }

    resources = ["*"]
  }
}
