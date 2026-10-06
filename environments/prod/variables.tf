variable "region" {
  description = "AWS region."
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment name, used as a prefix for resources."
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC. Does not overlap with dev (10.10.0.0/16) so the two can be peered later."
  type        = string
  default     = "10.20.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use."
  type        = number
  default     = 3
}

variable "kubernetes_version" {
  description = "EKS control plane version. Upgrade dev first, then prod."
  type        = string
  default     = "1.35"
}

variable "admin_principal_arns" {
  description = "IAM roles that get cluster-admin access (prefer roles over users in prod)."
  type        = list(string)
  default     = []
}
