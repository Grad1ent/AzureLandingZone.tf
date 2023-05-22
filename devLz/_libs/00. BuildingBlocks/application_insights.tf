resource "azurerm_application_insights" "application_insights" {

    for_each = var.application_insights
        location                = var.region
        
        name                    = each.value["name"]
        application_type        = each.value["application_type"]
        resource_group_name     = each.value["resource_group_name"]

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}