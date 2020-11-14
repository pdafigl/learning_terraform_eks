output "bucket_arn" {
  description = "ARN of bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamo_arn" {
  description = "ARN of bucket"
  value       = aws_dynamodb_table.terraform_state_lock.arn
}