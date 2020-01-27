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

resource "aws_s3_bucket_policy" "public-bucket-policy" {
  bucket = "${local.public-bucket}"
  policy = "${data.aws_iam_policy_document.s3-public-policy.json}"
}
