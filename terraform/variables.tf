variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-xxxxxxxx"  # Replace with your AMI ID
}

variable "key_name" {
  description = "The key pair name for SSH access to the EC2 instance"
  default     = "your-key-name"  # Replace with your key pair name
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "my-cluster"
}

variable "node_instance_type" {
  description = "The instance type for the EKS node group"
  default     = "t3.medium"
}

variable "node_group_size" {
  description = "The desired, minimum, and maximum number of nodes in the EKS node group"
  default     = 3
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for the frontend"
  default     = "my-frontend-bucket"
}

variable "cloudfront_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront"
  default     = "arn:aws:acm:us-east-1:xxxxxxxxxxxx:certificate/xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

