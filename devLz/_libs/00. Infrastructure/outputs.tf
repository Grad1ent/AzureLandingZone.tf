output "virtual_networks" {
  value = azurerm_virtual_network.virtual_networks
}

output "subnets" {
  value = azurerm_subnet.subnets
}

output "network_security_groups" {
  value = azurerm_network_security_group.network_security_groups
}