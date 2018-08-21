# --- AWS/compute/main.tf ---


# https://www.terraform.io/docs/providers/aws/d/ami.html
# ide note - AMI must match the region 
data "aws_ami" "server_ami" {
    most_recent     = true
    
    filter {
        name        = "owner-alias"
        values      = ["amazon"]
    }
    
    filter {
        name        = "name"
        values      = ["amzn-ami-hvm*-x86_64-gp2"]
    }
}

# Create a key pair

resource "aws_key_pair" "tf_auth" {
    key_name        = "${var.public_key_name}"
    public_key      = "${file(var.public_key_path)}"
}

# User Data 
# https://www.terraform.io/docs/providers/template/d/file.html
data "template_file" "user-init" {
    count = 2 # as many as EC2 instances 
    template = "${file("${path.module}/userdata.tpl")}"
}

# Deploy EC2 instance

resource "aws_instance" "tf_server" {
    count           = "${var.instance_count}"
    instance_type   = "${var.instance_type}"
    ami             = "${data.aws_ami.server_ami.id}"
    key_name        = "${aws_key_pair.tf_auth.id}"
    vpc_security_group_ids = ["${var.security_group}"]
    subnet_id       = "${element(var.subnets, count.index)}" # https://www.terraform.io/docs/configuration/interpolation.html#element-list-index-
    user_data       = "${data.template_file.user-init.*.rendered[count.index]}"
    
    tags {
        Name = "tf_server-${count.index +1}"
    }
    
    
}