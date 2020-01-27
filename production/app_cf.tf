resource "aws_cloudfront_distribution" "app-cf" {
  enabled = true
  is_ipv6_enabled = true
  retain_on_delete = true
  price_class = "PriceClass_200"

  aliases = "${local.app-domain}"

  origin {
    domain_name = "${local.public-bucket-fqdn}"
    origin_id   = "${local.app-prefix}-cf-error-access-id"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.public-img-identity.cloudfront_access_identity_path}"
    }
  }

  origin {
    domain_name = "${aws_alb.app-alb.dns_name}"
    origin_id = "${local.app-prefix}-cf-access-id"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # acm_certificate_arn = "${var.acm-arn}"
    # minimum_protocol_version = "TLSv1.2_2018"
    # ssl_support_method = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["HEAD", "GET"]
    target_origin_id = "${local.app-prefix}-cf-access-id"

    forwarded_values {
      headers = ["*"]
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    max_ttl = 0
    default_ttl = 0
  }

  ordered_cache_behavior {
    path_pattern     = "/errors/502.html"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.app-prefix}-cf-error-access-id"

    forwarded_values {
      query_string = false
      headers = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl = 300
    max_ttl = 300
    default_ttl = 300
    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern     = "/errors/504.html"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.app-prefix}-cf-error-access-id"

    forwarded_values {
      query_string = false
      headers = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl = 300
    max_ttl = 300
    default_ttl = 300
    viewer_protocol_policy = "redirect-to-https"
  }

  custom_error_response {
    error_code = "502"
    response_code = "502"
    response_page_path = "/errors/502.html"
    error_caching_min_ttl = "300"
  }

  custom_error_response {
    error_code = "504"
    response_code = "504"
    response_page_path = "/errors/504.html"
    error_caching_min_ttl = "300"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    bucket = "${local.private-logs-bucket-fqdn}"
    include_cookies = "false"
    prefix = "app/cloudfront"
  }

  tags {
    Name = "${local.app-prefix}-cf"
  }
}
