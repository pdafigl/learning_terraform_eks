# Create IAM Policy to manage bucket and DynamoDB Table
resource "aws_iam_policy" "terraform_state_bucket_policy" {
  name = var.policy_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "${var.bucket_arn}"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "${var.bucket_arn}/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
    }
    
  ]
}
EOF

}

# Create IAM user to manage bucket and DynamoDB Table
resource "aws_iam_user" "teraform_state_user" {
  name = var.user_name
  tags = {
    Name = "User for acces to bucket created for terraform state"
  }
}

# Create access and secret keys for user
resource "aws_iam_access_key" "terraform_state_access_key" {
  user = aws_iam_user.teraform_state_user.name
}

# Attach the policy to user
resource "aws_iam_policy_attachment" "terraform-state-attachment" {
  name       = "terraform-state-attachment"
  users      = [aws_iam_user.teraform_state_user.name]
  policy_arn = aws_iam_policy.terraform_state_bucket_policy.arn
}