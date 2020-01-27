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

data "aws_iam_policy_document" "s3-public-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${local.public-bucket-arn}/*"]

    principals {
      type = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.public-cf-identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${local.public-bucket-arn}"]

    principals {
      type = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.public-cf-identity.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "private-logs-bucket-policy" {
  bucket = "${local.private-logs-bucket}"
  policy = "${data.aws_iam_policy_document.s3-private-logs-policy.json}"
}

resource "aws_s3_bucket_policy" "public-bucket-policy" {
  bucket = "${local.public-bucket}"
  policy = "${data.aws_iam_policy_document.s3-public-policy.json}"
}
