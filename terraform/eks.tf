module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  vpc_id          = aws_vpc.main.id  # Assuming this is how VPC ID is provided

  tags = {
    Environment = "dev"
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "example"
  node_role_arn   = aws_iam_role.eks_node_role.arn  # Ensure aws_iam_role.eks_node_role is defined
  subnet_ids      = aws_subnet.public[*].id
  instance_types  = ["t3.medium"]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  // Attach policies or add other configurations as needed
}

