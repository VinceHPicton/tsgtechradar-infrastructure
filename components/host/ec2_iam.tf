resource "aws_iam_instance_profile" "host" {
  name = "${local.csi}-host"
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

resource "aws_iam_role" "host" {
  name        = "${local.csi}-host"
  description = "TSG Technology Radar Web ASG"

  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  tags = merge(
    local.default_tags,
    {
      "Name" = "${local.csi}-host"
    },
  )
}
