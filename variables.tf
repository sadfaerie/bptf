# --- AWS/variables.tf ---

variable "aws_region" {}
variable "bp_terraform_poc" {}
variable "vpc_cidr" {}
variable "public_cidr" {
    type = "list"
}
variable "ingress_ip" {}