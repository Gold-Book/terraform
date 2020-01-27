data "aws_elb_service_account" "private-alb-log" { }

data "aws_iam_policy_document" "s3-private-logs-policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetBucketAcl"
    ]
    resources = [
      "${local.private-logs-bucket-arn}/*",
      "${local.private-logs-bucket-arn}"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "${data.aws_elb_service_account.private-alb-log.id}"
      ]
    }

    principals {
      type = "Service"
      identifiers = [
        "logs.ap-northeast-1.amazonaws.com"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "private-logs-bucket-policy" {
  bucket = "${local.private-logs-bucket}"
  policy = "${data.aws_iam_policy_document.s3-private-logs-policy.json}"
}
