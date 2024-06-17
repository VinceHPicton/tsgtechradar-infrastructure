resource "aws_sns_topic" "healthyhosts" {
  name = "healthy_hosts_below_threshold"
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