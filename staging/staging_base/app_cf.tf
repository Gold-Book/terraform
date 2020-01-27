resource "aws_cloudfront_distribution" "app-cf" {
  enabled = true
  is_ipv6_enabled = true
  retain_on_delete = true
  price_class = "PriceClass_200"

  aliases = ["stg-ec.exampleapp.com"]

  default_root_object = "index.html"

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
    acm_certificate_arn = "${var.acm-arn}"
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method = "sni-only"
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

  custom_error_response {
    error_code = 404
    error_caching_min_ttl = 0
    response_code = 404
    response_page_path = "/404.html" # todo url
  }

  custom_error_response {
    error_code = 500
    error_caching_min_ttl = 0
    response_code = 500
    response_page_path = "/500.html" # todo url
  }

  custom_error_response {
    error_code = 502
    error_caching_min_ttl = 0
    response_code = 502
    response_page_path = "/500.html" # todo url
  }

  custom_error_response {
    error_code = 503
    error_caching_min_ttl = 0
    response_code = 503
    response_page_path = "/500.html" # todo url
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
