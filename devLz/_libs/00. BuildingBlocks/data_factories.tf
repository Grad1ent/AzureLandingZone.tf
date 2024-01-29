resource "azurerm_data_factory" "data_factories" {

    for_each = var.data_factories
        location                    = var.region
        
        name                        = each.value["name"]
        resource_group_name         = each.value["resource_group_name"]

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}