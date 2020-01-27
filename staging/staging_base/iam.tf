data "aws_iam_policy_document" "ec2-role-policy-data" {
  statement {
    effect = "Allow"
    actions = ["elasticache:*"]
    resources = ["arn:aws:elasticache:ap-northeast-1:663941361441:*"]
  }

  statement {
    effect = "Allow"
    actions = ["ses:*"]
    resources = ["arn:aws:ses:us-east-1:663941361441:*"]
  }

  statement {
    effect = "Allow"
    actions = ["ec2:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["elasticloadbalancing:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:Describe*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${var.stage}-exampleapp-public/*",
      "arn:aws:s3:::${var.stage}-exampleapp-private/*",
      "arn:aws:s3:::${var.stage}-exampleapp-private-logs/*",
      "arn:aws:s3:::exampleapp-deploy/*",
      "arn:aws:s3:::exampleapp-secure/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["logs:*"]
    resources = ["arn:aws:logs:ap-northeast-1:663941361441:*"]
  }

  statement {
    effect = "Allow"
    actions = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:aws:iam::*:role/aws-service-role/elasticache.amazonaws.com/AWSServiceRoleForElastiCache"]

    condition {
      test = "StringLike"
      variable = "iam:AWSServiceName"
      values = ["elasticache.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "ec2-iam-policy" {
  role   = "${aws_iam_role.ec2-iam-role.id}"
  name   = "exampleapp-ec2-policy"
  policy = "${data.aws_iam_policy_document.ec2-role-policy-data.json}"
}

resource "aws_iam_role" "ec2-iam-role" {
  name = "ec2-role"
  path = "/exampleapp/"
  description = "exampleapp ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-role-data.json}"
}

resource "aws_iam_instance_profile" "ec2-instance-role" {
    name = "exampleapp-ec2-instance-role"
    role = "${aws_iam_role.ec2-iam-role.name}"
}
