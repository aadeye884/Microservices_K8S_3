provider "aws" {
  profile = "Groupaccess"
  region = "us-west-2"
}


locals {
  name   = "my-vpc"
  region = "us-west-2"
  tags = {
    # Owner       = "user"
    Environment = "dev"
    Terraform   = "true"
    Name        = "my-vpc"
  }
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = var.vpc_cidr2


  azs             = var.availability_zones
  #private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  # azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # private_subnet_tags = {
  #   Name = format("private-subnet-%02d", count.index + 1)  #"private-subnet"
  # }

  public_subnet_tags = {
    Name = "public-subnet"    # format("public-subnet-%02d", count.index + 1)
  }

  # enable_nat_gateway = true
  # single_nat_gateway = true
  create_igw = true
  map_public_ip_on_launch = true
  tags = local.tags
}

