# AWS provider configuration
provider "aws" {
  version = "~> 3.0"
  region  = var.region
  profile = "default"
}

# Backend configuration. Creates or uses a S3 object to stores the terraform state
terraform {
  backend "s3" {
    region      = "eu-west-1"
    bucket      = "bk8s-terraform-states"
    key         = "DemoBK8S"
    max_retries = 5

    dynamodb_table = "bk8s-terraform-states-lock"
    encrypt        = true
    profile        = "tfstate"
  }
}


# Creates local variable with EKS cluster name
locals {
  cluster_name = "${var.project_name}-eks-${random_string.suffix.result}"
}