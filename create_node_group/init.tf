# AWS provider configuration
provider "aws" {
  version = "~> 3.0"
  region  = data.terraform_remote_state.eks.outputs.region
  profile = "default"
}

# Backend configuration. Creates or uses a S3 object to stores the terraform state
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "bk8s-terraform-states"
    key            = "node-00"
    max_retries    = 5
    dynamodb_table = "bk8s-terraform-states-lock"
    encrypt        = true
    profile        = "tfstate"
  }
}

# Creates a datasource with terraform state of EKS creation
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket  = "bk8s-terraform-states"
    key     = "DemoBK8S"
    region  = "eu-west-1"
    profile = "tfstate"
  }
}