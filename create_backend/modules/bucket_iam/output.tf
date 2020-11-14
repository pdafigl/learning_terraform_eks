output "terraform_state_access_key" {
  description = "Return the user access key"
  value       = aws_iam_access_key.terraform_state_access_key.id
}

output "terraform_state_secret_key" {
  description = "Return the user secret key"
  value       = aws_iam_access_key.terraform_state_access_key.secret
}