#/*
resource "azurerm_databricks_workspace" "databricks_workspaces" {

    for_each = var.databricks_workspaces
        location                        = var.region
        
        name                            = each.value["name"]
        sku                             = each.value["sku"]
        resource_group_name             = each.value["resource_group_name"]
        managed_resource_group_name     = each.value["managed_resource_group_name"]
        public_network_access_enabled   = each.value["public_network_access_enabled"]
        
        dynamic "custom_parameters" {
        
            for_each = each.value.custom_parameters
            content{
                virtual_network_id                                      = var.virtual_networks["${custom_parameters.value.vnet}"].id

                private_subnet_name                                     = custom_parameters.value.private_subnet_name
                private_subnet_network_security_group_association_id    = var.network_security_groups["${custom_parameters.value.private_nsg}"].id

                public_subnet_name                                      = custom_parameters.value.public_subnet_name
                public_subnet_network_security_group_association_id     = var.network_security_groups["${custom_parameters.value.public_nsg}"].id
            }
        }

    lifecycle {
        ignore_changes = [tags]
    }  

}
#*/