# Module VPC from https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

# Get availability zones on region
data "aws_availability_zones" "available" {}

# Create VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name            = "${var.project_name}-vpc"
  cidr            = var.cidr
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true


  # Tags for associates subnets to EKS cluster
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}"  = "shared"
    "kubernetes.io/role/elb-${local.cluster_name}" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}"           = "shared"
    "kubernetes.io/role/internal-elb-${local.cluster_name}" = "1"
  }
}

# Create security group 
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.cidr_blocks
  }
}