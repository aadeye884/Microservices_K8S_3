variable "vpc_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
variable "vpc_cidr2" {
  type    = string
  default = "10.0.0.0/16"
}
/* variable "accesskey" {
  default = ""
}
variable "secretkey" {
  default = ""
} */
variable "ami_id" {
  type    = string
  default = "ami-017fecd1353bcc96e"
}
variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
variable "ssh_user" {
  type    = string
  default = "ubuntu"
}
variable "master_node_count" {
  type    = number
  default = 3
}
variable "worker_node_count" {
  type    = number
  default = 3
}
variable "master_instance_type" {
  type    = string
  default = "t2.medium"
}
variable "worker_instance_type" {
  type    = string
  default = "t2.medium"
}
variable "clusterlb_instance_type" {
  type    = string
  default = "t2.medium"
}
variable "associate_public_ip_address" {
  type    = string
  default = false
}