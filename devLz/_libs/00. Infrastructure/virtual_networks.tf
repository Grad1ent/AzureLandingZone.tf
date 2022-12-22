resource "azurerm_virtual_network" virtual_networks {

    for_each = module.cmdb.virtual_networks
        location = module.cmdb.region
        
        name = each.value["name"]
        address_space = each.value["address_space"]
        resource_group_name = each.value["resource_group_name"]
        
        dynamic "subnet" {
        
            for_each = each.value.subnets
            content{
                name = subnet.value.name
                address_prefix = subnet.value.address_prefix
                security_group = azurerm_network_security_group.network_security_groups[subnet.value.nsg].id
            }   
        
        }

    lifecycle {
        ignore_changes = [tags]
    }
  
}
