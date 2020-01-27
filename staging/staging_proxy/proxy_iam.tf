data "aws_iam_policy_document" "proxy-role-policy-data" {
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
}

data "aws_iam_policy_document" "proxy-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "proxy-iam-role" {
  name = "stg-exampleapp-proxy-role"
  path = "/exampleapp/"
  description = "exampleapp proxy instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.proxy-role-data.json}"
}

resource "aws_iam_role_policy" "proxy-iam-policy" {
  role   = "${aws_iam_role.proxy-iam-role.id}"
  name   = "stg-exampleapp-proxy-policy"
  policy = "${data.aws_iam_policy_document.proxy-role-policy-data.json}"
}

resource "aws_iam_instance_profile" "proxy-instance-role" {
    name = "stg-exampleapp-proxy-instance-role"
    role = "${aws_iam_role.proxy-iam-role.name}"
}
