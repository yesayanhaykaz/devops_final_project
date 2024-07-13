variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_2_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.30.0/24"
}

variable "private_1_subnet_cidrs" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "private_2_subnet_cidrs" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.40.0/24"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t2.micro"
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
  default     = "my-frontend-bucket-"
}

