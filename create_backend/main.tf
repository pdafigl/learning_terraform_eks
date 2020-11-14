# Create bucket with bucket module
module "bucket" {
  source              = "./modules/bucket"
  bucket_name         = var.bucket_name
  dynamodb_table_name = var.dynamodb_table_name

}

# Create iam policy and user for work with the created bucket, using bucket_iam module
module "user_policy" {
  source              = "./modules/bucket_iam"
  user_name           = var.user_name
  policy_name         = var.policy_name
  bucket_arn          = module.bucket.bucket_arn
  dynamodb_table_name = var.dynamodb_table_name
}