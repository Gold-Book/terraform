data "aws_iam_policy_document" "managed-role-data" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "managed-iam-role" {
  name = "${local.managed-prefix}-ec2-iam-role"
  path = "/exampleapp/"
  description = "exampleapp managed ec2 instance policy"
  assume_role_policy = "${data.aws_iam_policy_document.managed-role-data.json}"
}
