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
