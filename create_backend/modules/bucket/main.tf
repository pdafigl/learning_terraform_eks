
# For create de bucket resource
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  # Enable versioning
  versioning {
    enabled = true
  }
  # Mark as private bucket
  acl = "private"

  lifecycle {
    prevent_destroy = true
  }

  # Change the tags. you can create it like variables
  tags = {
    Name        = "S3 Remote Terraform State Store"
    Environment = "Demo BK8S"
  }
}


# For create a dynamo table for state lock control
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  # The name of index must be LockID
  attribute {
    name = "LockID"
    type = "S"
  }

  # Change the tags. you can create it like variables
  tags = {
    Name        = "DynamoDB Terraform State Lock Table"
    Environment = "Demo BK8S"
  }
}