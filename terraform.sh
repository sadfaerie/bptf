echo "Downloading and unpacking Terraform..."
sudo curl -O https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip 
sudo unzip terraform_0.11.8_linux_amd64.zip -d /usr/local/bin/ 
echo ""
echo "Done. Terraform is now ready."
terraform --version
echo ""
echo "Creating directories and config files..."
mkdir -p {network,storage,compute}
touch {.,network,storage,compute}/{main.tf,variables.tf,outputs.tf}
touch terraform.tfvars
echo ""
echo "Done. Enjoy Terraforming!"
echo ""