data "aws_iam_policy_document" "app-role-policy-data" {
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

data "aws_iam_policy_document" "app-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app-iam-role" {
  name = "${local.app-prefix}-ec2-iam-role"
  path = "/exampleapp/"
  description = "exampleapp app ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.app-role-data.json}"
}

resource "aws_iam_role_policy" "app-iam-policy" {
  role   = "${aws_iam_role.app-iam-role.id}"
  name   = "${local.app-prefix}-ec2-iam-policy"
  policy = "${data.aws_iam_policy_document.app-role-policy-data.json}"
}
