packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.1"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "ami_name" {
  default = "ami-0a0e5d9c7acc336f1"
}

variable "aws_access_key" {
  type = string
  sensitive = true
  default = ""
}

variable "aws_secret_key" {
  type = string
  sensitive = true
  default = ""
}

source "amazon-ebs" "example" {
  region         = var.aws_region
  source_ami     = var.ami_name
  instance_type  = var.instance_type
  ssh_username   = var.ssh_username
  ami_name       = "testubuntu-mongodb_ami"
  access_key     = var.aws_access_key       
  secret_key     = var.aws_secret_key   
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "ansible" {
    playbook_file = "../ansible/test_playbook.yml"
  }
}

