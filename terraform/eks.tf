module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  subnets         = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id

  node_groups = {
    eks_nodes = {
      desired_capacity = var.node_group_size
      max_capacity     = var.node_group_size
      min_capacity     = var.node_group_size

      instance_type = var.node_instance_type
    }
  }

  tags = {
    Environment = "dev"
  }
}

