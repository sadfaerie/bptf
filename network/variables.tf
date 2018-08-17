# --- AWS/network/variables.tf --- 

variable "vpc_cidr" {}

variable "public_cidr" {
    type = "list"
    }

variable "ingress_ip" {}