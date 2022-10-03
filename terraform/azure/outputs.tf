# Outputs file
output "catapp_url" {
  value = "http://${azurerm_public_ip.catapp-pip.fqdn}"
}

output "catapp_ip" {
  value = "http://${azurerm_public_ip.catapp-pip.ip_address}"
}

output "win_ip" {
  value = "http://${azurerm_public_ip.win-pip.ip_address}"
}