resource "azurerm_public_ip" "public_ip_addresses" {

    for_each = var.public_ip_addresses
        location            = var.region
        
        name                = each.value["name"]
        sku                 = each.value["sku"]
        allocation_method   = each.value["allocation_method"]
        resource_group_name = each.value["resource_group_name"]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}