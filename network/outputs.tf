# --- AWS/network/outputs.tf --- 

output "VPC" {
    value = "${aws_vpc.tf_vpc.id}"
}