output "vpc_id" {
  description = "ID of the dev VPC."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnets (for EKS nodes)."
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnets (for load balancers)."
  value       = module.vpc.public_subnet_ids
}

output "nat_public_ips" {
  description = "Outbound IPs of the environment."
  value       = module.vpc.nat_public_ips
}
