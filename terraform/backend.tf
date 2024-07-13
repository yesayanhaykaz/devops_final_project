terraform {
  backend "s3" {
    bucket         = "aca-final-tf-backend"
    key            = "terraform/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

