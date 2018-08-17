# --- AWS/network/main.tf --- 

data "aws_availability_zones" "available" {} 

# --- VPC ---

resource "aws_vpc" "tf_vpc" {
    cidr_block = "${var.vpc_cidr}"    
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags {
        Name = "TF_BP_VPC"
    }
}


resource "aws_internet_gateway" "tf_internet_gateway" {
    vpc_id = "${aws_vpc.tf_vpc_id}"
    
    tags {
        Name = "TF_BP_IGW"
    }
}

resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vpc_id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
    }
    
    tags {
        Name = "TF_BP_RT_public"
    }
}

resource "aws_default_route_table" "tf_private_rt" {
    default_route_table_id = "${aws_vpc.tf_vpc_id.default_route_table.id}"
    
    tags {
        Name = "TF_BP_RT_default"
    }
}