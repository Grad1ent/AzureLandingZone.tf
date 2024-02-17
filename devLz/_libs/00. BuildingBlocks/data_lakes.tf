/*
resource "azurerm_storage_data_lake_gen2_filesystem" "data_lakes" {

    for_each = var.data_lakes
        
        name                        = each.value["name"]
        storage_account_id          = azurerm_storage_account.storage_accounts[each.value["storage_account"]].id

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_storage_account.storage_accounts]
        
}
*/