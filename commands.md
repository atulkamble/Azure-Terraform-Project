1. Launch AzureVM-Linux-Ubuntu
2. sudo apt update -y
3. curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
4. sudo apt-get update
5. sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
6. sudo mkdir -p /etc/apt/keyrings
7. curl -sLS https://packages.microsoft.com/keys/microsoft.asc |   gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
8. sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
9. AZ_DIST=$(lsb_release -cs)
10. echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
sudo apt-get update
sudo apt-get install azure-cli
az --version
az upgrade

Ref: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
