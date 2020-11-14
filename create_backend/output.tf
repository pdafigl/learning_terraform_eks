output "bucket_arn" {
  description = "ARN of bucket"
  value       = module.bucket.bucket_arn
}

output "dynamodb_arn" {
  description = "ARN of DynamoDB Table"
  value       = module.bucket.dynamo_arn
}

output "terraform_state_access_key" {
  description = "Show the access_key to use the bucket"
  value       = module.user_policy.terraform_state_access_key
}

output "terraform_state_secret_key" {
  description = "Show the secret_key to use the bucket"
  value       = module.user_policy.terraform_state_secret_key
}