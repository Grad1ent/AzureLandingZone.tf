resource "azurerm_container_registry" "container_registries" {

    for_each = var.container_registries
        location                = var.region
        
        name                    = each.value["name"]
        sku                     = each.value["sku"]
        resource_group_name     = each.value["resource_group_name"]
        admin_enabled           = each.value["admin_enabled"]

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}