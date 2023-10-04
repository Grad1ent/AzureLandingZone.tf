resource "azurerm_storage_account" "storage_accounts" {

    for_each = var.storage_accounts
        location                    = var.region
        
        name                        = each.value["name"]
        resource_group_name         = each.value["resource_group_name"]
        account_tier                = each.value["account_tier"]
        account_replication_type    = each.value["account_replication_type"]

        depends_on              = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}