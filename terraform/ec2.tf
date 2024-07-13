resource "aws_instance" "database_server" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  monitoring    = true
  subnet_id     = aws_subnet.private[0].id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "database-server"
  }
}

