# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Specify the AWS provider version
    }
  }
}

provider "aws" {
  region = var.region
}
