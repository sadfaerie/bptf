# --- AWS/network/variables.tf --- 

variable "vpc_cidr" {
    default = "10.100.0.0/16"
}

variable "public_cidr" {
    default = [
    "10.100.1.0/24", 
    "10.100.2.0/24"
    ]
}


variable "ingress_ip" {
    default = "0.0.0.0/0"
}