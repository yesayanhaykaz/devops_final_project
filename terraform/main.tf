provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
module "ec2_instance" {
  source          = "terraform-aws-modules/ec2-instance/aws"
  version         = "3.3.0"
  instance_count  = 1
  name            = "database-server"
  ami             = "ami-xxxxxxxx"  # Replace with your AMI ID
  instance_type   = "t2.micro"
  key_name        = "your-key-name"  # Replace with your key pair name
  monitoring      = true
  subnet_id       = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "database-server"
  }
}

# EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.21"
  subnets         = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 3
      min_capacity     = 3

      instance_type = "t3.medium"
    }
  }

  tags = {
    Environment = "dev"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "frontend" {
  bucket = "my-frontend-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "frontend_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "S3-my-frontend-bucket"

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
    target_origin_id = "S3-my-frontend-bucket"

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
    acm_certificate_arn = "arn:aws:acm:us-east-1:xxxxxxxxxxxx:certificate/xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for my S3 bucket"
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.oai.id}"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.frontend.arn}/*"
      }
    ]
  })
}

