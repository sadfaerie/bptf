# --- AWS/main.tf --- 

provider "aws" {
    region = "${var.aws_region}"
}



# STORAGE MODULE

module "storage" {
    source = "./storage"
    bp_terraform_poc = "${var.bp_terraform_poc}"

}