
resource "azurerm_cognitive_account" "open_ai" {

    for_each = var.open_ai
        location                                = var.region
        
        resource_group_name                     = each.value["resource_group_name"]        
        name                                    = each.value["name"]
        kind                                    = each.value["kind"]
        sku_name                                = each.value["sku_name"]

        identity {
            type = "SystemAssigned"
        }        
    
        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
