terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "terraform/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

