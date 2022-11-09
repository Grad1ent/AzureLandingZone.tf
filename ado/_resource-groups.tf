resource "azurerm_resource_group" "rg_hub" {
  name     = var.rg_hub_name
  location = var.location
}

resource "azurerm_resource_group" "rg_spoke_01" {
  name     = var.rg_spoke_01_name
  location = var.location
}


