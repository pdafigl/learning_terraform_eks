# The user name to create
variable "user_name" {
  type = string
}

# The policy name to create
variable "policy_name" {
  type = string
}

# Bucket ARN to create the policy
variable "bucket_arn" {
  type = string
}

# DynamoDB table name to create the policy
variable "dynamodb_table_name" {
  type = string
}
