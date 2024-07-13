
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  instance_tenancy = "default"

  enable_dns_support = true

  enable_dns_hostnames = true

  enable_classiclink = false

  enable_classiclink_dns_support = false

  assign_generated_ipv6_cidr_block = false

}

### SUBNETS ###
resource "aws_subnet" "public_1" {
  count                   = 1
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name                        = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "public_2" {
  count                   = 1
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_2_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name                        = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private_1" {
  count      = 1
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_1_subnet_cidrs
  availability_zone = "us-east-1a"

  tags = {
    Name                              = "private-us-east-1a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  count      = 1
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_2_subnet_cidrs
  availability_zone = "us-east-1b"

  tags = {
    Name                              = "private-us-east-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}


### CREATING IGW ###
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway 1"
  }

}

### PUBLIC ROUTE TABLE ###
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

### PRIVATE ROUTE TABLE ###
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }
}

### NAT 1 ###
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1[0].id
}

### NAT 2 ###
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_2[0].id
}

### CONNECT ROUTE TABLE ###
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1[0].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2[0].id
  route_table_id = aws_route_table.private.id
}



resource "aws_eip" "nat_1" {
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat_2" {
  depends_on = [aws_internet_gateway.gw]
}



output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  sensitive = false
}

