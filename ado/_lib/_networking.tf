#
# Hub
#
resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.vnet_hub_name
  address_space       = var.vnet_hub_address_space
  location            = var.location
  resource_group_name = var.rg_hub_name
}

resource "azurerm_subnet" "snet_hub_bastion" {
  name                 = var.snet_hub_bastion_name
  resource_group_name  = var.rg_hub_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = var.snet_hub_bastion_address_prefixes
}

resource "azurerm_subnet" "snet_hub" {
  name                 = var.snet_hub_name
  resource_group_name  = var.rg_hub_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = var.vnet_hub_address_space
}

#
# Spoke 01
#
resource "azurerm_virtual_network" "vnet_spoke_01" {
  name                = var.vnet_spoke_01_name
  address_space       = var.vnet_spoke_01_address_space
  location            = var.location
  resource_group_name = var.rg_spoke_01_name
}

resource "azurerm_subnet" "snet_spoke_01" {
  name                 = var.snet_spoke_01_name
  resource_group_name  = var.rg_spoke_01_name
  virtual_network_name = var.vnet_spoke_01_name
  address_prefixes     = var.snet_spoke_01_address_prefixes
}

#
# Peering hub <> spoke(s)
#
resource "azurerm_virtual_network_peering" "peer_hub_spoke_01" {
  name                      = "hub-spoke_01"
  resource_group_name       = azurerm_resource_group.rg_hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke_01.id
}

resource "azurerm_virtual_network_peering" "peer_spoke_01_hub" {
  name                      = "spoke_01-hub"
  resource_group_name       = azurerm_resource_group.rg_spoke_01.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}

#
# NSGs
#
resource "azurerm_network_security_group" "nsg_snet_hub_bastion" {
  name                = var.nsg_snet_hub_bastion_name
  location            = var.location
  resource_group_name = var.rg_hub_name
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_hub_bastion" {
  subnet_id                 = azurerm_subnet.snet_hub_bastion.id
  network_security_group_id = azurerm_network_security_group.nsg_snet_hub_bastion.id
}

resource "azurerm_network_security_group" "nsg_snet_hub" {
  name                = var.nsg_snet_hub_name
  location            = var.location
  resource_group_name = var.rg_hub_name
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_hub" {
  subnet_id                 = azurerm_subnet.snet_hub
  network_security_group_id = azurerm_network_security_group.nsg_snet_hub.id
}

resource "azurerm_network_security_group" "nsg_snet_spoke_01" {
  name                = var.nsg_snet_spoke_01_name
  location            = var.location
  resource_group_name = var.rg_spoke_01_name
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_spoke_01" {
  subnet_id                 = azurerm_subnet.snet_spoke_01
  network_security_group_id = azurerm_network_security_group.nsg_snet_spoke_01
}


