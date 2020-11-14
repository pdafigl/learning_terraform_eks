# Provider configuration
# You can provide de access key and the secret kye with aws cli configure,
# or create environment variables TF_VAR_access_key and TF_VAR_secret_key
provider "aws" {
  version    = "~> 3.0"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}