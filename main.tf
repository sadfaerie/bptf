# --- AWS/main.tf --- 

provider "aws" {
    region = "${var.aws_region}"
}



# STORAGE MODULE

module "storage" {
    source = "./storage"
    bp_terraform_poc = "${var.bp_terraform_poc}"

}


# NETWORK MODULE

module "network" {
    source = "./network"
    vpc_cidr = "${var.vpc_cidr}"
    public_cidr = "${var.public_cidr}"
    ingress_ip = "${var.ingress_ip}"
}