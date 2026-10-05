# Module: vpc

Creates a production-style VPC spread across several availability zones.

```
                 Internet
                     │
              Internet Gateway
                     │
   ┌─────────────────┼─────────────────┐
   │ public subnet A │ public subnet B │   ← load balancers, NAT
   │      NAT        │   (NAT in prod) │
   ├─────────────────┼─────────────────┤
   │ private subnet A│ private subnet B│   ← EKS nodes, databases
   └─────────────────┴─────────────────┘
```

## Features

- Public and private subnet per availability zone
- NAT gateway: one shared (`single_nat_gateway = true`, cheaper) or one per AZ (highly available)
- Separate private route table per AZ
- Subnet tags for EKS load balancer discovery (`cluster_name`)
- VPC flow logs to CloudWatch with a least-privilege IAM role
- Default security group locked down (no rules)
- Public subnets do **not** auto-assign public IPs

## Usage

```hcl
module "vpc" {
  source = "../../modules/vpc"

  name                 = "dev"
  cidr_block           = "10.10.0.0/16"
  azs                  = ["eu-central-1a", "eu-central-1b"]
  public_subnet_cidrs  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]
  single_nat_gateway   = true
}
```

## Inputs

| Name | Description | Default |
|---|---|---|
| `name` | Name prefix for resources | — |
| `cidr_block` | VPC CIDR | — |
| `azs` | Availability zones (≥ 2) | — |
| `public_subnet_cidrs` | One CIDR per AZ | — |
| `private_subnet_cidrs` | One CIDR per AZ | — |
| `single_nat_gateway` | One shared NAT instead of one per AZ | `true` |
| `cluster_name` | EKS cluster name for subnet tags | `null` |
| `flow_logs_retention_days` | Flow log retention | `30` |
| `tags` | Extra tags | `{}` |

## Outputs

`vpc_id`, `vpc_cidr_block`, `public_subnet_ids`, `private_subnet_ids`, `nat_public_ips`
