
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  # Makes your instances shared on the host.
  instance_tenancy = "default"

  # Required for EKS. Enable/disable DNS support in the VPC.
  enable_dns_support = true

  # Required for EKS. Enable/disable DNS hostnames in the VPC.
  enable_dns_hostnames = true

  # Enable/disable ClassicLink for the VPC.
  enable_classiclink = false

  # Enable/disable ClassicLink DNS Support for the VPC.
  enable_classiclink_dns_support = false

  # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC.
  assign_generated_ipv6_cidr_block = false

}

resource "aws_subnet" "public_1" {
  count                   = 1
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

# A map of tags to assign to the resource.
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

# A map of tags to assign to the resource.
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

  # A map of tags to assign to the resource.
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

  # A map of tags to assign to the resource.
  tags = {
    Name                              = "private-us-east-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  # A map of tags to assign to the resource.
  tags = {
    Name = "NAT 1"
  }

}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1[0].id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_2[0].id
}

resource "aws_eip" "nat_1" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat_2" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1[0].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2[0].id
  route_table_id = aws_route_table.private.id
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
  sensitive = false
}
