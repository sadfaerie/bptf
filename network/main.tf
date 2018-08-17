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

# --- IGW ---

resource "aws_internet_gateway" "tf_internet_gateway" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    
    tags {
        Name = "TF_BP_IGW"
    }
}


# --- ROUTING TABLES ---

resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
    }
    
    tags {
        Name = "TF_BP_RT_public"
    }
}

resource "aws_default_route_table" "tf_private_rt" {
    default_route_table_id = "{aws_vpc.tf_vpc.default_route_table.id}"
    
    tags {
        Name = "TF_BP_RT_default"
    }
}


# --- SUBNETS ---
# https://www.terraform.io/docs/providers/aws/r/subnet.html

resource "aws_subnet" "tf_public_subnet" {
    count = 2 
    vpc_id = "${aws_vpc.tf_vpc.id}"
    cidr_block = "${var.public_cidr{count.index]}"
    
    # Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false.
    map_public_ip_on_launch = true
    
    # https://www.terraform.io/docs/providers/aws/d/availability_zones.html
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    
    tags {
        Name = "TF_BP_SUB_public_${count.index +1}"
    }
}


resource "aws_route_table_association" "tf_public_association" {
    count = "${aws_subnet.tf_public_subnet.count}"
    subnet_id = "${aws_subnet.tf_public_subnet.*.id[count.index]"
    route_table_id = "${aws_route_table.tf_public_rt.id}"
}


# --- SECURITY GROUPS ---
# https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_group" "tf_public_sg" {
    name = "tf_public_sg"
    description = "Access for public faced instances"
    vpc_id = "${aws_vpc.tf_vpc.id}"
    
    # --- traffic IN ssh---
    ingress {
        from_port = 22 
        to_port = 22 
        protocol = "tcp"
        cidr_blocks  = ["${var.ingress_ip}"]
    }
    
    
    # --- traffic IN http---
    ingress {
        from_port = 80 
        to_port = 80
        protocol = "tcp"
        cidr_blocks  = ["${var.ingress_ip}"]
    }
    
    # --- traffic OUT ---
    egress {
        from_port = 0 # ALLOW ALL
        to_port = 0
        protocol = "-1" # ALLOW ANY
        cidr_blocks = ["0.0.0.0/0"]
    }
}