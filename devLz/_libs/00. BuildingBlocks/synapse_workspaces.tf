/*
resource "azurerm_synapse_workspace" "synapse_workspaces" {

    for_each = var.synapse_workspaces
        location                                = var.region
        
        resource_group_name                     = each.value["resource_group_name"]        
        name                                    = each.value["name"]
        storage_data_lake_gen2_filesystem_id    = azurerm_storage_data_lake_gen2_filesystem.data_lakes[each.value["data_lake"]].id
        
        identity {
            type = "SystemAssigned"
        }        
    
        depends_on              = [azurerm_resource_group.resource_groups, azurerm_storage_data_lake_gen2_filesystem.data_lakes]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/