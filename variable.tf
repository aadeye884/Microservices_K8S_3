variable "region" {}
variable "profile" {}
variable "vpc_cidr" {}
variable "vpc_cidr2" {}
/* variable "accesskey" {
  default = ""
}
variable "secretkey" {
  default = ""
} */
variable "ami_id" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "availability_zones" {}
variable "ssh_user" {}
variable "master_node_count" {}
variable "worker_node_count" {}
variable "master_instance_type" {}
variable "worker_instance_type" {}
variable "clusterlb_instance_type" {}
variable "associate_public_ip_address" {}
variable "ami_Jenkins_id" {}
variable "Environment" {}