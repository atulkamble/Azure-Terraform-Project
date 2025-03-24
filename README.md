# Project: Azure 3-Tier Infrastructure using Terraform

## 💡 Description

This project provisions a simple 3-tier architecture in Azure using Terraform. It includes a virtual network, subnets, NSGs, and a web VM with NGINX.

## ✅ Prerequisites

- Azure CLI
- Terraform CLI
- Azure Subscription

## 🚀 How to Use

### 1. Clone the repo
```bash
git clone https://github.com/atulkamble/Azure-Terraform-Project
cd Azure-Terraform-Project
```

Here’s a **complete Azure Terraform project** with **code and documentation**, ideal for deploying a basic 3-tier architecture (web, app, and database) using **Azure Virtual Network**, **Virtual Machines**, and **Network Security Groups**. This project can serve as a solid starting point for real-world scenarios.

---

## 🔧 Project Name: Azure 3-Tier Infrastructure using Terraform

### 📂 Folder Structure
```
azure-terraform-3tier/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── README.md
└── scripts/
    └── install_nginx.sh
```

---

## ✅ Features

- Resource Group  
- Virtual Network with Subnets (Web, App, DB)
- Network Security Groups (NSGs)
- Public IP for Web Tier  
- Virtual Machines in each tier
- NGINX installed on Web VMs (via provisioner)
- Output of public IP of Web VMs

---

## 1️⃣ `main.tf`
```hcl
provider "azurerm" {
  features {}
  subscription_id = "cc57cd42-dede-4674-b810-a0fbde41504a"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-main"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "web_pip" {
  name                = "web-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "web_nic" {
  name                = "web-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-ip-config"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_pip.id
  }
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "web_nic_nsg" {
  network_interface_id      = azurerm_network_interface.web_nic.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_linux_virtual_machine" "web_vm" {
  name                            = "web-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password  # Using a password for authentication
  network_interface_ids           = [azurerm_network_interface.web_nic.id]
  disable_password_authentication = false  # Enable password authentication

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "echo '<h1>Provisioned by Terraform (Atul)</h1>' | sudo tee /var/www/html/index.html"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.web_pip.ip_address
    }
  }
}

```

---

## 2️⃣ `variables.tf`
```hcl
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "East US"  # Change this if needed
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

```

---

## 3️⃣ `terraform.tfvars`
```hcl
resource_group_name = "my-resource-group"
location           = "East US"
admin_username     = "azureuser"
admin_password     = "SecurePassw0rd!"
```

---

## 4️⃣ `outputs.tf`
```hcl
output "web_vm_public_ip" {
  value = azurerm_public_ip.web_pip.ip_address
}
```

---

## 5️⃣ `README.md`

```markdown
# Azure 3-Tier Infrastructure using Terraform

## 💡 Description

This project provisions a simple 3-tier architecture in Azure using Terraform. It includes a virtual network, subnets, NSGs, and a web VM with NGINX.

## ✅ Prerequisites

- Azure CLI
- Terraform CLI
- Azure Subscription

## 🚀 How to Use

### 1. Clone the repo
```bash
git clone https://github.com/your-repo/azure-terraform-3tier.git
cd azure-terraform-3tier
```

### 2. Login to Azure
```bash
az login
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Apply the configuration
```bash
terraform apply
```

### 5. Access NGINX
Once applied, get the public IP from the output and open in browser:
```bash
terraform output web_vm_public_ip
```

## 📁 File Structure

- `main.tf`: Infrastructure code
- `variables.tf`: Input variables
- `outputs.tf`: Output values
- `terraform.tfvars`: Sensitive values
- `scripts/install_nginx.sh`: Script to install NGINX

## 🔐 Security

Ensure passwords and sensitive info are stored securely (consider using Azure Key Vault).

## 📌 Future Improvements

- Add App and DB Tier
- Add Load Balancer
- Use Key Vault for secrets
- Add autoscaling and monitoring

```

---

## Want to Expand It?

Let me know if you want to:
- Add Azure Load Balancer or Application Gateway
- Use Azure Database for MySQL/PostgreSQL instead of VM
- Deploy multi-VM scale sets with autoscaling
- Integrate with Azure DevOps Pipelines

Would you like me to zip and share the whole project for download or create a GitHub repo link format for copy-paste?
