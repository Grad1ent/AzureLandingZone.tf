resource "azurerm_virtual_network" virtual_networks {

    for_each = var.virtual_networks
        location            = var.region
        
        name                = each.value["name"]
        address_space       = each.value["address_space"]
        resource_group_name = each.value["resource_group_name"]
        /*
        dynamic "subnet" {
        
            for_each = each.value.subnets
            content{
                name            = subnet.value.name
                address_prefix  = subnet.value.address_prefix
                security_group  = azurerm_network_security_group.network_security_groups[subnet.value.nsg].id
        }
        */
    lifecycle {
        ignore_changes = [tags]
    }
  
}

resource "azurerm_virtual_network_peering" "virtual_network_peerings" {

    for_each = var.virtual_network_peerings
        
        name                        = each.value["name"]
        resource_group_name         = each.value["resource_group_name"]

        virtual_network_name        = azurerm_virtual_network.virtual_networks[each.value["src_vnet"]].name
        remote_virtual_network_id   = azurerm_virtual_network.virtual_networks[each.value["dst_vnet"]].id

}

resource "azurerm_subnet" subnets {

    for_each = var.subnets
        virtual_network_name    = each.value["virtual_network_name"]
        resource_group_name     = each.value["resource_group_name"]

        name                    = each.value["name"]
        address_prefixes        = each.value["address_prefixes"]
        
        dynamic "delegation" {
            for_each = each.value.delegations
        
            content {
                name = "delegation"
                service_delegation {
                    name    = delegation.value.name
                    actions = delegation.value.actions
                }        
            }
        }

}