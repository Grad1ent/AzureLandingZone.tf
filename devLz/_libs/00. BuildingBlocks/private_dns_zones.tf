resource "azurerm_private_dns_zone" "private_dns_zones" {

    for_each = var.private_dns_zones       
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_links" {

    for_each = var.private_dns_zones       
        name                    = each.value["vnet_link_name"]
        resource_group_name     = each.value["resource_group_name"]
        private_dns_zone_name   = each.value["name"]
        virtual_network_id      = azurerm_virtual_network.virtual_networks["${each.value["vnet"]}"].id

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_virtual_network.virtual_networks, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
