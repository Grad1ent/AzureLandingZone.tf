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
    
    for_each = var.machine_learning_compute_instances
        location                        = var.region
        
        name                            = each.value["ci_name"]
        machine_learning_workspace_id   = azurerm_machine_learning_workspace.machine_learning_workspaces["${each.value["ci_workspace"]}"].id
        virtual_machine_size            = each.value["ci_size"]
        subnet_resource_id              = azurerm_subnet.subnets["${each.value["ci_subnet"]}"].id

        identity {
            type = "SystemAssigned"
        }

        depends_on = [azurerm_machine_learning_workspace.machine_learning_workspaces]
}

resource "azurerm_machine_learning_compute_cluster" "machine_learning_cc" {

    for_each = var.machine_learning_compute_clusters
        location                        = var.region
        
        name                            = each.value["cc_name"]
        machine_learning_workspace_id   = azurerm_machine_learning_workspace.machine_learning_workspaces["${each.value["cc_workspace"]}"].id
        vm_size                         = each.value["cc_size"]
        subnet_resource_id              = azurerm_subnet.subnets["${each.value["cc_subnet"]}"].id

        vm_priority                     = each.value["cc_priority"]
        
        scale_settings {
            min_node_count                       = each.value["cc_min_node_count"]
            max_node_count                       = each.value["cc_max_node_count"]
            scale_down_nodes_after_idle_duration = each.value["cc_idle"]
        }

        identity {
            type = "SystemAssigned"
        }

        depends_on = [azurerm_machine_learning_workspace.machine_learning_workspaces]
}

resource "azurerm_machine_learning_inference_cluster" "machine_learning_inference_clusters" {

    for_each = var.machine_learning_inference_clusters
        location                        = var.region
        
        name                            = each.value["ic_name"]
        machine_learning_workspace_id   = azurerm_machine_learning_workspace.machine_learning_workspaces["${each.value["ic_workspace"]}"].id
        kubernetes_cluster_id           = azurerm_kubernetes_cluster.kubernetes_clusters["${each.value["ic_aks"]}"].id
        cluster_purpose                 = each.value["ic_purpose"]

        identity {
            type = "SystemAssigned"
        }

        depends_on = [azurerm_machine_learning_workspace.machine_learning_workspaces,azurerm_kubernetes_cluster.kubernetes_clusters]
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