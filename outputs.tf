# --- AWS/outputs.tf

output "Bucket" {
    value = "${module.storage.bucketname}"
}