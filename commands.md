1. Launch AzureVM-Linux-Ubuntu
2. // install python
3. sudo apt install python3 -y
4. sudo apt install python-is-python3
5. sudo apt update -y
6. // install git
7. sudo apt install git -y
8. git --version
   
9. curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
10. sudo apt-get update
11. sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
12. sudo mkdir -p /etc/apt/keyrings
13. curl -sLS https://packages.microsoft.com/keys/microsoft.asc |   gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
14. sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
15. AZ_DIST=$(lsb_release -cs)
16. echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
sudo apt-get update
sudo apt-get install azure-cli
az --version
az upgrade
// install terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt-get install terraform
terraform --version



Ref: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
