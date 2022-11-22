# variable "region" {
#   default = "eu-west-2"
# }
# variable "vpc_name" {
#   default = "my-vpc"
# }
# variable "azs_zone1" {
#   type = list(string)
#   default = ["eu-west-2a", "us-west-2a"]
# }
# variable "azs_zone2" {
#   type = list(string)
#   default = ["eu-west-2b", "us-west-2b"]
# }
# variable "azs_zone3" {
#   type = list(string)
#   default = ["eu-west-2c", "us-west-2c"]
# }
# variable "Amis" {
#   type = map
#   default = {
#   eu-west-2 = "ami-0f540e9f488cfa27d"
#   us-west-2 = "ami-017fecd1353bcc96e"
#   us-east-1 = "ami-0d73480446600f555"}
# }
# variable "private_key_path" {
#   default = file("~/Keypairs/pub")
# }
# variable "public_key_path" {
#   default = file("~/Keypairs/pub.pub")
# }
# variable "region" {
#   type = list(string)
#   default = ["eu-west-2", "us-west-2"]
# }
variable "vpc_cidr" {
    type = string
    default = "0.0.0.0/0"
}
variable "vpc_cidr2" {
    type = string
    default = "10.0.0.0/16"
}
variable "master_node_count" {
    type = number
    default = 1
}
variable "ami_id" {
    type = string
    default = "ami-017fecd1353bcc96e"
}
variable "worker_node_count" {
    type = number
    default = 2
}
variable "master_instance_type" {
    type = string
    default = "t3.small"
}
variable "worker_instance_type" {
    type = string
    default = "t3.micro"
}
# variable "private_subnets" {
#     type = list(string)
#     default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }
variable "public_subnets" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
variable "ssh_user" {
    type = string
    default = "ubuntu"
}

# variable "keyname" {
#   type = string
#   default = "dev_keypair"
# }
# variable "path_to_public_key" {
#   type = string
#   default = "~/Keypairs/ssh_keypair.pub"
# }
