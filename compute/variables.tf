# --- AWS/compute/variables.tf ---

variable "public_key_name" {}

variable "public_key_path" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
    type = "list"
}