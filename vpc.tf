 provider "aws" {
  region = var.region
  profile = var.profile 
} 

locals {
  name = "${terraform.workspace}-vpc"
  /* region = var.region */
  /* tags = "${terraform.workspace}-testing-tags" */
  tags = {
    Environment = var.Environment
    Terraform   = "true"
    Name        = local.name
  }
  name_Jenkins = "${terraform.workspace}-Jenkins"
}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = local.name
  cidr            = var.vpc_cidr2
  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  public_subnet_tags = {
    Name = "public-subnet"
  }
  private_subnet_tags = {
    Name = "private-subnet"
  }

  enable_nat_gateway      = true
  single_nat_gateway      = true
  create_igw              = true
  map_public_ip_on_launch = true
  tags                    = local.tags
}
