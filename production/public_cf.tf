resource "aws_cloudfront_distribution" "public-cf" {
  enabled = true
  is_ipv6_enabled = true
  retain_on_delete = true
  price_class = "PriceClass_200"
  default_root_object = "404.html" # todo 決める
  aliases = ["${local.public-domain}"]

  origin {
    domain_name = "${local.public-bucket-fqdn}"
    origin_id   = "${local.public-bucket}-cf-access-id"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.public-img-identity.cloudfront_access_identity_path}"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.public-bucket}-cf-access-id"

    forwarded_values {
      query_string = false
      headers = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 300
    max_ttl = 300
    default_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm-arn}"
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method = "sni-only"
  }

  logging_config {
    bucket = "${local.private-logs-bucket-fqdn}"
    include_cookies = "false"
    prefix = "public/cloudfront"
  }

  tags {
    Name = "${local.public-prefix}-cf"
  }
}
