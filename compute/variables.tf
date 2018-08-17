# --- AWS/compute/variables.tf ---

variable "key_name" {
    default = "tfkey"
}


variable "public_key_path" {
    default = "/home/ec2-user/.ssh/id_rsa.pub" 
}