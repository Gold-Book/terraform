data "aws_iam_policy_document" "proxy-role-policy-data" {
  statement {
    effect = "Allow"
    actions = ["ec2:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["s3:*Object"]
    resources = ["${local.deploy-target-arn}"]
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
  name = "${local.proxy-prefix}-ec2-iam-role"
  path = "/exampleapp/"
  description = "exampleapp proxy ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.proxy-role-data.json}"
}

resource "aws_iam_role_policy" "proxy-iam-policy" {
  role   = "${aws_iam_role.proxy-iam-role.id}"
  name   = "${local.proxy-prefix}-ec2-iam-policy"
  policy = "${data.aws_iam_policy_document.proxy-role-policy-data.json}"
}
