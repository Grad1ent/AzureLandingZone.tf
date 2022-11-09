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
  virtual_network_name = var.vnet_hub_name
  address_prefix       = var.snet_hub_bastion_address_prefix
  resource_group_name  = var.rg_hub_name
}

resource "azurerm_subnet" "snet_hub" {
  name                 = var.snet_hub_name
  virtual_network_name = var.vnet_hub_name
  address_prefix       = var.snet_hub_address_prefix
  resource_group_name  = var.rg_hub_name
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
  virtual_network_name = var.vnet_spoke_01_name
  address_prefix       = var.snet_spoke_01_address_prefix
  resource_group_name  = var.rg_spoke_01_name
}











