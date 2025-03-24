// Azure Terraform Project 

Ref: (Azure CLI) https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
Ref: (Terraform) https://developer.hashicorp.com/terraform/install?product_intent=terraform#linux

Instructions:

1. RG named my-resource-group not existed in acccount 
2. Copy and Paste your subscription-id in main.tf 
3. Confirm Website URL http://public-ip

1. Launch and connect azure VM 
```
cd Downloads 
chmod 400 key.pem
ssh -i key.pem atul@20.244.14.59
```

```
sudo apt install python3 -y
python3 --version
```

```
sudo apt install git -y
git --version
```

```
sudo apt install tree -y
tree --version
```
2. Install Azure CLI 

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
```

```
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
```

```
sudo apt-get update
sudo apt-get install azure-cli
az --version
```

3. login to azure account via az cli 
```
az login 
```

4. install terraform 

```
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```
```
sudo apt update && sudo apt install terraform
```
```
terraform --version
```

5. Clone Project Code 

```
git clone https://github.com/atulkamble/Azure-Terraform-Project.git
cd Azure-Terraform-Project
```
```
tree 
```
```
terraform init 
terraform validate 
terraform fmt
terraform plan 
terraform apply 
terraform destroy
```

6. Check instance public-ip in browser ``` http://public-ip```

