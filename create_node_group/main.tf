# Creates a node group resource on EKS. This instances are managed by EKS directly
# More info in https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
resource "aws_eks_node_group" "node00" {
  cluster_name    = data.terraform_remote_state.eks.outputs.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = data.terraform_remote_state.eks.outputs.worker_iam_role_arn
  subnet_ids      = data.terraform_remote_state.eks.outputs.public_subnet_ids
  instance_types  = ["t2.small"]

  labels = { "environment" = "dev" }

  # Configures de min and max number of instances
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  # Configures the remote access to instances. Uses a SSH Key created on AWS
  remote_access {
    source_security_group_ids = [data.terraform_remote_state.eks.outputs.management_security_group]
    ec2_ssh_key               = var.ssh_key
  }
  tags = {
    Project = "Add Node Grup to EKS for Demo BK8S"
  }
}