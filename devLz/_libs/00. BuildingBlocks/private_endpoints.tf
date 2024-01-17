/*
resource "azurerm_private_endpoint" "private_endpoints_st_file" {

    for_each = var.private_endpoints_st_file
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        subnet_id               = azurerm_subnet.subnets["${each.value["subnet"]}"].id

        private_service_connection {
            name                            = each.value["psc_name"]

            private_connection_resource_id  = azurerm_storage_account.storage_accounts["${each.value["psc_resource"]}"].id
            subresource_names               = each.value["psc_subresource_names"]
            is_manual_connection            = each.value["psc_is_manual_connection"]
        }
        
        private_dns_zone_group {
            name                            = each.value["dns_group_name"]
            private_dns_zone_ids            = [azurerm_private_dns_zone.private_dns_zones["${each.value["dns_zone"]}"].id]
        }

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/
/*
resource "azurerm_private_endpoint" "private_endpoints_st_blob" {

    for_each = var.private_endpoints_st_blob
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        subnet_id               = azurerm_subnet.subnets["${each.value["subnet"]}"].id

        private_service_connection {
            name                            = each.value["psc_name"]

            private_connection_resource_id  = azurerm_storage_account.storage_accounts["${each.value["psc_resource"]}"].id
            subresource_names               = each.value["psc_subresource_names"]
            is_manual_connection            = each.value["psc_is_manual_connection"]
        }
        
        private_dns_zone_group {
            name                            = each.value["dns_group_name"]
            private_dns_zone_ids            = [azurerm_private_dns_zone.private_dns_zones["${each.value["dns_zone"]}"].id]
        }

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/
/*
resource "azurerm_private_endpoint" "private_endpoints_kv" {

    for_each = var.private_endpoints_kv
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        subnet_id               = azurerm_subnet.subnets["${each.value["subnet"]}"].id

        private_service_connection {
            name                            = each.value["psc_name"]

            private_connection_resource_id  = azurerm_key_vault.key_vaults["${each.value["psc_resource"]}"].id
            subresource_names               = each.value["psc_subresource_names"]
            is_manual_connection            = each.value["psc_is_manual_connection"]
        }
        
        private_dns_zone_group {
            name                            = each.value["dns_group_name"]
            private_dns_zone_ids            = [azurerm_private_dns_zone.private_dns_zones["${each.value["dns_zone"]}"].id]
        }

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/
/*
resource "azurerm_private_endpoint" "private_endpoints_creg" {

    for_each = var.private_endpoints_creg
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        subnet_id               = azurerm_subnet.subnets["${each.value["subnet"]}"].id

        private_service_connection {
            name                            = each.value["psc_name"]

            private_connection_resource_id  = azurerm_container_registry.container_registries["${each.value["psc_resource"]}"].id
            subresource_names               = each.value["psc_subresource_names"]
            is_manual_connection            = each.value["psc_is_manual_connection"]
        }
        
        private_dns_zone_group {
            name                            = each.value["dns_group_name"]
            private_dns_zone_ids            = [azurerm_private_dns_zone.private_dns_zones["${each.value["dns_zone"]}"].id]
        }

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/
/*
resource "azurerm_private_endpoint" "private_endpoints_aml" {

    for_each = var.private_endpoints_aml
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        subnet_id               = azurerm_subnet.subnets["${each.value["subnet"]}"].id

        private_service_connection {
            name                            = each.value["psc_name"]

            private_connection_resource_id  = azurerm_machine_learning_workspace.machine_learning_workspaces["${each.value["psc_resource"]}"].id
            subresource_names               = each.value["psc_subresource_names"]
            is_manual_connection            = each.value["psc_is_manual_connection"]
        }
        
        private_dns_zone_group {
            name                            = each.value["dns_group_name"]
            private_dns_zone_ids            = [azurerm_private_dns_zone.private_dns_zones["${each.value["dns_zone"]}"].id]
        }

        depends_on              = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets, azurerm_private_dns_zone.private_dns_zones]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
*/