module "ec2_instance" {
  source          = "terraform-aws-modules/ec2-instance/aws"
  version         = "3.3.0"
  instance_count  = 1
  name            = "database-server"
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  monitoring      = true
  subnet_id       = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "database-server"
  }
}

