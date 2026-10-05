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

  # /16 -> /24 subnets: public 10.10.0.x, 10.10.1.x ... private 10.10.10.x, 10.10.11.x ...
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

  # dev: one NAT gateway to keep costs down
  single_nat_gateway = true

  cluster_name = "${var.environment}-eks"
}
