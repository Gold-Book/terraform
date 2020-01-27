data "aws_iam_policy_document" "admin-role-policy-data" {
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

data "aws_iam_policy_document" "admin-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "admin-iam-role" {
  name = "${local.admin-prefix}-ec2-iam-role"
  path = "/exampleapp/"
  description = "exampleapp admin ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.admin-role-data.json}"
}

resource "aws_iam_role_policy" "admin-iam-policy" {
  role   = "${aws_iam_role.admin-iam-role.id}"
  name   = "${local.admin-prefix}-ec2-iam-policy"
  policy = "${data.aws_iam_policy_document.admin-role-policy-data.json}"
}
