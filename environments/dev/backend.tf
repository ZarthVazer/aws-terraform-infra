terraform {
  backend "s3" {
    bucket       = "zarthvazer-terraform-state" # created by ../../bootstrap
    key          = "dev/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true # S3-native state locking, no DynamoDB table needed
  }
}
