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
  resource_group_name       = azurerm_resource_group.rg_spoke_01
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}






