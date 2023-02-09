resource "azurerm_network_interface" "network_interface_cards" {

    for_each = var.network_interface_cards
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]

        dynamic "ip_configuration" {
        
            for_each = each.value.ip_configuration
            content{
                name                            = ip_configuration.value.name
                subnet_id                       = azurerm_subnet.subnets["${ip_configuration.value.subnet}"].id
                private_ip_address_allocation   = ip_configuration.value.private_ip_address_allocation
            }
        }

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}