output "web_vm_public_ip" {
  value = azurerm_public_ip.web_pip.ip_address
}
