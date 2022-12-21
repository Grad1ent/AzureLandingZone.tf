resource "azurerm_virtual_network_peering" "virtual_network_peerings" {

    for_each = module.cmdb.virtual_network_peerings
        
        name                        = each.value["name"]
        resource_group_name         = each.value["resource_group_name"]

        virtual_network_name        = azurerm_virtual_network.virtual_networks[each.value["src_vnet"]].name
        remote_virtual_network_id   = azurerm_virtual_network.virtual_networks[each.value["dst_vnet"]].id

}