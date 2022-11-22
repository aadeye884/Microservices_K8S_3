# terraform {
#   backend "s3" {
#   bucket = "group-1-terraform-state"
#   key = "terraform/backend"
#   region = "eu-west-2"
#   }
# }

# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#     }
#     random = {
#       source = "hashicorp/random"
#     }
#   }
#   backend "remote" {
#   organization = "sockshop"
    
#     workspaces {
#       name = "sockshop"
#     }
#   }
# }
