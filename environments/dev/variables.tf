variable "region" {
  description = "AWS region."
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment name, used as a prefix for resources."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use."
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "EKS control plane version."
  type        = string
  default     = "1.35"
}

variable "api_allowed_cidrs" {
  description = "Your IPs (/32) allowed to reach the Kubernetes API from the internet. Empty = private endpoint only."
  type        = list(string)
  default     = []
}

variable "admin_principal_arns" {
  description = "IAM users/roles that get cluster-admin access."
  type        = list(string)
  default     = []
}
