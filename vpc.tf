provider "aws" {
  region = "us-west-2"
  profile = "Groupaccess"
  shared_credentials_files = ["~/.aws/credentials"]
  /* access_key = var.accesskey
  secret_key = var.secretkey */
}

locals {
  name   = "my-vpc"
  region = "us-west-2"
  tags = {
    Environment = "dev"
    Terraform   = "true"
    Name        = "my-vpc"
  }
}

module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  name           = local.name
  cidr           = var.vpc_cidr2
  azs            = var.availability_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

  public_subnet_tags = {
    Name = "public-subnet"
  }
  private_subnet_tags = {
    Name = "private-subnet"
  }

  enable_nat_gateway = true
  single_nat_gateway = true
  create_igw              = true
  map_public_ip_on_launch = true
  tags                    = local.tags
}
