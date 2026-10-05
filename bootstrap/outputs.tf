output "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state."
  value       = aws_s3_bucket.state.id
}

output "state_kms_key_arn" {
  description = "ARN of the KMS key that encrypts the state."
  value       = aws_kms_key.state.arn
}
