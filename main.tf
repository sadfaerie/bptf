# --- AWS/main.tf --- 

provider "aws" {
    region = "${var.aws_region}"
}

# NETWORK MODULE

module "network" {
    source = "./network"
    vpc_cidr = "${var.vpc_cidr}"
    public_cidr = "${var.public_cidr}"
    ingress_ip = "${var.ingress_ip}"
}



# STORAGE MODULE

module "storage" {
    source = "./storage"
    bp_terraform_poc = "${var.bp_terraform_poc}"

}


# COMPUTE MODULE

module "compute" {
    source = "./compute"
    instance_count  = "${var.instance_count}"
    instance_type   = "${var.instance_type}"
    public_key_name = "${var.public_key_name}"
    public_key_path = "${var.public_key_path}"
    subnets         = "${module.network.public_subnets}"
    security_group  = "${module.network.public_sg}"
}