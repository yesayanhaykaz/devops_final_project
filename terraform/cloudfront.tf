resource "time_static" "epoch" {}
locals {
  s3_name = "${var.s3_bucket_name}-${time_static.epoch.unix}"
}
resource "aws_s3_bucket" "frontend" {
  bucket = local.s3_name 
  # other configurations as needed
}

resource "aws_cloudfront_distribution" "frontend_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "S3-${var.s3_bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
#    acm_certificate_arn = var.cloudfront_certificate_arn
#    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]  # Add your desired countries or leave as needed

      # Uncomment and adjust as needed for IP address or IP range restrictions
      # ip_addresses = ["10.0.2.0/24", "10.0.1.0/24"]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for my S3 bucket"
}

