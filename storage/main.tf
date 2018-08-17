# --- AWS/storage/main.tf --- 

# create a random id (globally unique bucket name)
# https://www.terraform.io/docs/providers/random/index.html

resource "random_id" "tf_bucket_id" {
    byte_length = 2
}

# create a bucket

resource "aws_s3_bucket" "tf_bucket" {
    bucket = "${var.bp_terraform_poc}-${random_id.tf_bucket_id.dec}"
    acl    = "private"
    force_destroy = true
    
    tags {
        Name = "tf_bucket"
    }
}