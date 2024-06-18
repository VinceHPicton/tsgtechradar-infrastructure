resource "aws_sns_topic" "healthyhosts" {
  name = "${var.project}_Healthy_Hosts_Below_Threshold"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_policy" "healthyhosts" {
  arn = aws_sns_topic.healthyhosts.arn

  policy = data.aws_iam_policy_document.healthyhosts.json
}

data "aws_iam_policy_document" "healthyhosts" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.healthyhosts.arn,
    ]

    sid = "__default_statement_ID"
  }
}


resource "aws_sns_topic" "cpuutilization" {
  name = "${var.project}_High_Cpu_Utilization"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_policy" "cpuutilization" {
  arn = aws_sns_topic.cpuutilization.arn

  policy = data.aws_iam_policy_document.cpuutilization.json
}

data "aws_iam_policy_document" "cpuutilization" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.cpuutilization.arn,
    ]

    sid = "__default_statement_ID"
  }
}

resource "aws_sns_topic" "highresponsetime" {
  name = "${var.project}_High_Response_Time"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_policy" "highresponsetime" {
  arn = aws_sns_topic.highresponsetime.arn

  policy = data.aws_iam_policy_document.highresponsetime.json
}

data "aws_iam_policy_document" "highresponsetime" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.highresponsetime.arn,
    ]

    sid = "__default_statement_ID"
  }
}
