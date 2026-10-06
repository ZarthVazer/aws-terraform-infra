output "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state."
  value       = aws_s3_bucket.state.id
}

output "state_kms_key_arn" {
  description = "ARN of the KMS key that encrypts the state."
  value       = aws_kms_key.state.arn
}

output "github_plan_role_arn" {
  description = "Set this as the AWS_PLAN_ROLE_ARN repository variable to enable terraform plan in pull requests."
  value       = aws_iam_role.github_plan.arn
}

output "aws_account_id" {
  description = "AWS account the backend was created in."
  value       = data.aws_caller_identity.current.account_id
}
