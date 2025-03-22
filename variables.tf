variable "resource_group_name" {
  default = "terraform-rg"
}

variable "location" {
  default = "East US"
}

variable "admin_username" {
  description = "Admin username for VMs"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VMs"
  sensitive   = true
}
