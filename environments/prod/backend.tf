terraform {
  backend "s3" {
    bucket       = "zarthvazer-terraform-state" # created by ../../bootstrap
    key          = "prod/terraform.tfstate"     # separate state: dev changes can never touch prod
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}
