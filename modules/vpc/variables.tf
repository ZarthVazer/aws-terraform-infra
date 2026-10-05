variable "name" {
  description = "Name prefix for all resources, e.g. \"dev\"."
  type        = string
}

variable "cidr_block" {
  description = "IPv4 CIDR block of the VPC."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.cidr_block))
    error_message = "cidr_block must be a valid IPv4 CIDR, e.g. 10.0.0.0/16."
  }
}

variable "azs" {
  description = "Availability zones to spread subnets across."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2
    error_message = "Use at least two availability zones for high availability."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of public subnets, one per availability zone."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks of private subnets, one per availability zone."
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Use one shared NAT gateway (cheaper, for dev) instead of one per AZ (highly available, for prod)."
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "If set, subnets are tagged so an EKS cluster with this name can place load balancers in them."
  type        = string
  default     = null
}

variable "flow_logs_retention_days" {
  description = "How long VPC flow logs are kept in CloudWatch."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Extra tags for all resources."
  type        = map(string)
  default     = {}
}
