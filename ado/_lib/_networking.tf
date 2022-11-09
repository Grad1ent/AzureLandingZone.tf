#
# Hub
#
resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.vnet_hub_name
  address_space       = var.vnet_hub_address_space
  location            = var.location
  resource_group_name = var.rg_hub_name

  subnet{
    name                 = var.snet_hub_bastion_name
    address_prefix       = var.snet_hub_bastion_address_prefix
  }

  subnet {
    name                 = var.snet_hub_name
    address_prefix       = var.snet_hub_address_prefix
  }
}

#
# Spoke 01
#
resource "azurerm_virtual_network" "vnet_spoke_01" {
  name                = var.vnet_spoke_01_name
  address_space       = var.vnet_spoke_01_address_space
  location            = var.location
  resource_group_name = var.rg_spoke_01_name

  subnet {
    name               = var.snet_spoke_01_name
    address_prefix     = var.snet_spoke_01_address_prefix
  }
}