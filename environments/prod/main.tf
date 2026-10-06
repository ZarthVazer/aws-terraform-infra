provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "aws-terraform-infra"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  public_subnet_cidrs  = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i)]
  private_subnet_cidrs = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i + 10)]
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = var.environment
  cidr_block           = var.vpc_cidr
  azs                  = local.azs
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs

  # prod: one NAT gateway per AZ, so losing an AZ doesn't cut egress for the others
  single_nat_gateway = false

  flow_logs_retention_days = 90
  cluster_name             = "${var.environment}-eks"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "${var.environment}-eks"
  kubernetes_version = var.kubernetes_version
  subnet_ids         = module.vpc.private_subnet_ids

  # prod: API reachable only from inside the VPC (VPN / bastion / CI runners in the VPC)
  endpoint_public_access = false
  admin_principal_arns   = var.admin_principal_arns

  # prod: on-demand capacity, at least two nodes spread over three AZs
  node_capacity_type  = "ON_DEMAND"
  node_instance_types = ["m6i.large"]
  node_min_size       = 2
  node_desired_size   = 3
  node_max_size       = 6

  log_retention_days = 90
}
