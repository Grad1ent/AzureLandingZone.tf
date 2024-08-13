/*
resource "azurerm_bastion_host" "bastion_hosts" {

    for_each = var.bastion_hosts
        location            = var.region
        
        name                = each.value["name"]
        sku                 = each.value["sku"]
        tunneling_enabled   = each.value["tunneling_enabled"]
        resource_group_name = each.value["resource_group_name"]

        ip_configuration {
            name                 = "pip"
            #subnet_id            = azurerm_virtual_network.virtual_networks[each.value["vnet"]].subnet.*.id[0]
            subnet_id            = azurerm_subnet.subnets[each.value["snet"]].id
            public_ip_address_id = azurerm_public_ip.public_ip_addresses[each.value["pip"]].id
        }

        depends_on = [azurerm_resource_group.resource_groups,azurerm_subnet.subnets,azurerm_public_ip.public_ip_addresses]

    lifecycle {
        ignore_changes = [tags]
    }  

}
*/