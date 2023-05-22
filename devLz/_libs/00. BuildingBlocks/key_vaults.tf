data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vaults" {

    for_each = var.key_vaults
        location                    = var.region
        
        name                        = each.value["name"]
        sku_name                    = each.value["sku_name"]
        resource_group_name         = each.value["resource_group_name"]
        purge_protection_enabled    = each.value["purge_protection_enabled"]
        tenant_id                   = data.azurerm_client_config.current.tenant_id

        depends_on = [azurerm_resource_group.resource_groups]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}