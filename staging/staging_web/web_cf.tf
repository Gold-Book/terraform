resource "aws_cloudfront_distribution" "web-cf" {
  enabled = true
  is_ipv6_enabled = true
  retain_on_delete = true
  web_acl_id = "2f3ef474-10f5-49b2-be2f-395fcc6c1856"
  price_class = "PriceClass_200"

  aliases = ["stg.exampleapp.com"]

  default_root_object = "index.html"

  origin {
    domain_name = "stg-web01.exampleapp.com"
    origin_id = "${local.web-prefix}-cf-access-id"

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
    target_origin_id = "${local.web-prefix}-cf-access-id"

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

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    bucket = "${local.private-logs-bucket-fqdn}"
    include_cookies = "false"
    prefix = "web/cloudfront"
  }

  tags {
    Name = "${local.web-prefix}-cf"
  }
}
