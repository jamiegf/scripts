provider "aws" {
  region     = "us-west-1" # N California
  access_key = "AKIAUVBUS6JDGKEEUXWI"
  secret_key =  "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"
}

# VPC Module!

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "web-vpc"
  cidr = "10.191.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.191.1.0/24", "10.191.2.0/24", "10.191.3.0/24"]
  public_subnets  = ["10.191.101.0/24", "10.191.102.0/24", "10.191.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "PRD"
  }
}