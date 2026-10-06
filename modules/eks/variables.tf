variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes minor version of the control plane, e.g. \"1.35\"."
  type        = string
  default     = "1.35"
}

variable "subnet_ids" {
  description = "Private subnets for the control plane ENIs and worker nodes."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "EKS needs subnets in at least two availability zones."
  }
}

variable "endpoint_public_access" {
  description = "Expose the Kubernetes API publicly (restricted by public_access_cidrs). Keep false in prod."
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to reach the public API endpoint, e.g. your office or home IP /32."
  type        = list(string)
  default     = []

  validation {
    condition     = !contains(var.public_access_cidrs, "0.0.0.0/0")
    error_message = "Do not open the Kubernetes API to the whole internet; use specific CIDRs."
  }
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "ON_DEMAND or SPOT. SPOT is much cheaper and fine for dev."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Initial number of worker nodes (later managed by the autoscaler)."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "admin_principal_arns" {
  description = "IAM users/roles that get cluster-admin through EKS access entries."
  type        = list(string)
  default     = []
}

variable "log_retention_days" {
  description = "Retention of control plane logs in CloudWatch."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Extra tags for all resources."
  type        = map(string)
  default     = {}
}
