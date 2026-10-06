# Module: eks

Amazon EKS cluster with a managed node group, secure defaults and everything needed to run workloads that talk to AWS.

## Features

- **Private by default**: API endpoint reachable only from inside the VPC; optional public access restricted to given CIDRs (`0.0.0.0/0` is rejected by validation)
- **Secrets encrypted with KMS** (envelope encryption, key rotation on)
- **All control plane logs** (api, audit, authenticator, controllerManager, scheduler) with limited retention
- **Access entries** (`authentication_mode = "API"`) instead of the legacy `aws-auth` ConfigMap
- **IRSA**: IAM OIDC provider so pods can assume IAM roles without static keys
- **Managed node group** on Amazon Linux 2023, ON_DEMAND or SPOT, rolling updates one node at a time
- **Core add-ons** managed by EKS: vpc-cni, kube-proxy, CoreDNS, Pod Identity agent
- Nodes reachable through **SSM Session Manager**, no SSH keys

## Usage

```hcl
module "eks" {
  source = "../../modules/eks"

  cluster_name       = "dev-eks"
  kubernetes_version = "1.35"
  subnet_ids         = module.vpc.private_subnet_ids

  endpoint_public_access = true
  public_access_cidrs    = ["203.0.113.10/32"] # your IP

  node_capacity_type = "SPOT"
  node_instance_types = ["t3.medium", "t3a.medium"]
}
```

Then connect:

```bash
aws eks update-kubeconfig --name dev-eks --region eu-central-1
kubectl get nodes
```

## Inputs

| Name | Description | Default |
|---|---|---|
| `cluster_name` | Cluster name | — |
| `kubernetes_version` | Control plane version | `"1.35"` |
| `subnet_ids` | Private subnets (≥ 2 AZs) | — |
| `endpoint_public_access` | Public API endpoint | `false` |
| `public_access_cidrs` | Allowed CIDRs for public endpoint | `[]` |
| `node_instance_types` | Node instance types | `["t3.medium"]` |
| `node_capacity_type` | `ON_DEMAND` or `SPOT` | `"ON_DEMAND"` |
| `node_min_size` / `node_desired_size` / `node_max_size` | Node group scaling | `1` / `2` / `3` |
| `admin_principal_arns` | IAM principals with cluster-admin | `[]` |
| `log_retention_days` | Control plane log retention | `30` |
| `tags` | Extra tags | `{}` |

## Outputs

`cluster_name`, `cluster_endpoint`, `cluster_certificate_authority_data`, `cluster_security_group_id`, `oidc_provider_arn`, `node_role_arn`
