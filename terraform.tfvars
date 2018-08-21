# EU-WEST-1 Ireland
aws_region = "eu-west-1"

bp_terraform_poc = "bp-terraform"

vpc_cidr = "10.100.0.0/16"

public_cidr = [
    "10.100.1.0/24", 
    "10.100.2.0/24"
    ]

ingress_ip = "0.0.0.0/0"

public_key_name = "tfkey"
public_key_path = "/home/ec2-user/.ssh/id_rsa.pub" 
instance_type = "t2.micro" 
instance_count =2