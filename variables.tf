# --- AWS/variables.tf ---

variable "aws_region" {}


variable "bp_terraform_poc" {}


variable "vpc_cidr" {}
variable "public_cidr" {
    type = "list"
}
variable "ingress_ip" {}


variable "public_key_name" {}
variable "public_key_path" {}
variable "instance_count" {
    default = 1 # will deploy at least 1 instance
}
variable "instance_type" {}
