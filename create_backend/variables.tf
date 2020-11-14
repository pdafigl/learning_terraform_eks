# Access and secret keys
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

# Region to deploy infrastructure
variable "region" {
  type    = string
  default = "eu-west-1"
}

# Bucket name
variable "bucket_name" {
  type = string
}

# Dynamo table name 
variable "dynamodb_table_name" {
  type = string
}

# Variables for IAM role and user Definition
variable "user_name" {
  type = string

}

variable "policy_name" {
  type = string
}
