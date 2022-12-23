/*
resource "azurerm_bastion_host" "bastion_hosts" {

    for_each = module.cmdb.bastion_hosts
        location            = module.cmdb.region
        
        name                = each.value["name"]
        sku                 = each.value["sku"]
        resource_group_name = each.value["resource_group_name"]

        ip_configuration {
            name                 = "pip"
            #subnet_id            = azurerm_virtual_network.virtual_networks[each.value["vnet"]].subnet.*.id[0]
            subnet_id            = azurerm_subnet.subnets[each.value["snet"]].id
            public_ip_address_id = azurerm_public_ip.public_ip_addresses[each.value["pip"]].id
        }
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/