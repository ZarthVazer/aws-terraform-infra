output "vpc_id" {
  description = "ID of the prod VPC."
  value       = module.vpc.vpc_id
}

output "nat_public_ips" {
  description = "Outbound IPs of the environment (one per AZ)."
  value       = module.vpc.nat_public_ips
}

output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "oidc_provider_arn" {
  description = "OIDC provider for IRSA roles."
  value       = module.eks.oidc_provider_arn
}
