resource "azurerm_virtual_network" virtual_networks {

    for_each = module.cmdb.virtual_networks
        location            = module.cmdb.region
        
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

resource "azurerm_subnet" subnets {

    for_each = module.cmdb.subnets
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
                    #actions = delegation.value.actions
                }        
            }
        }
}