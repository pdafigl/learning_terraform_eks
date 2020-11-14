# Module EKS from https://github.com/terraform-aws-modules/terraform-aws-eks

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  # Use a auto-genearted name
  cluster_name = local.cluster_name
  # Last version of K8S supported on AWS EKS
  cluster_version = "1.18"
  # Get de private subnets from VPC module
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  # Create instances as worker nodes. EKS doesn't manage this instances, because only manages node groups
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
      asg_desired_capacity          = 1
    },
  ]
}


# Data for Kubernetes provider configuration
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}