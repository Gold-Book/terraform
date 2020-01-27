data "aws_iam_policy_document" "web-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "web-iam-role" {
  name = "${local.web-prefix}-ec2-iam-role"
  path = "/exampleapp/"
  description = "exampleapp web ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.web-role-data.json}"
}
