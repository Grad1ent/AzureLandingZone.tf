resource "azurerm_machine_learning_workspace" "machine_learning_workspaces" {

    for_each = var.machine_learning_workspaces
        location                        = var.region
        
        name                            = each.value["name"]
        resource_group_name             = each.value["resource_group_name"]
        application_insights_id         = azurerm_application_insights.application_insights["${each.value["application_insights"]}"].id
        container_registry_id           = azurerm_container_registry.container_registries["${each.value["container_registry"]}"].id
        storage_account_id              = azurerm_storage_account.storage_accounts["${each.value["storage_account"]}"].id
        key_vault_id                    = azurerm_key_vault.key_vaults["${each.value["key_vault"]}"].id
        public_network_access_enabled   = each.value["public_network_access_enabled"]
        
        identity {
            type = "SystemAssigned"
        }

        depends_on = [azurerm_resource_group.resource_groups,azurerm_application_insights.application_insights,azurerm_key_vault.key_vaults,azurerm_storage_account.storage_accounts,azurerm_container_registry.container_registries]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}

resource "azurerm_machine_learning_compute_instance" "machine_learning_ci" {

    for_each = var.machine_learning_workspaces
        location                        = var.region
        
        name                            = each.value["ci_name"]
        machine_learning_workspace_id   = azurerm_machine_learning_workspace.machine_learning_workspaces["${each.key}"].id
        virtual_machine_size            = each.value["ci_size"]
        subnet_resource_id              = azurerm_subnet.subnets["${each.value["ci_subnet"]}"].id
        
        identity {
            type = "SystemAssigned"
        }

        depends_on = [azurerm_machine_learning_workspace.machine_learning_workspaces]
}
/*
resource "null_resource" "enableIdleShutdown" {

    for_each = var.machine_learning_workspaces
        provisioner "local-exec" {
            #https://management.azure.com/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${each.value["resource_group_name"]}/providers/Microsoft.MachineLearningServices/workspaces/${each.value["name"]}/computes/${each.value["ci_name"]}/updateIdleShutdownSetting?api-version=2021-07-01
            command = "${path.module}/enableIdleShutdown.cmd"
        }

    depends_on = [azurerm_machine_learning_compute_instance.machine_learning_ci]
}
*/