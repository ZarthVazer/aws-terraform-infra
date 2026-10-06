variable "region" {
  description = "AWS region for the state bucket."
  type        = string
  default     = "eu-central-1"
}

variable "state_bucket_name" {
  description = "Globally unique name of the S3 bucket that stores Terraform state."
  type        = string
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default = {
    Project   = "aws-terraform-infra"
    ManagedBy = "terraform"
  }
}

variable "github_repository" {
  description = "GitHub repository (owner/name) whose workflows may assume the CI role."
  type        = string
  default     = "ZarthVazer/aws-terraform-infra"
}
