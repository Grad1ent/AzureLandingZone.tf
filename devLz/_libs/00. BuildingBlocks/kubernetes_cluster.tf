#/*
resource "azurerm_kubernetes_cluster" "kubernetes_clusters" {

    for_each = var.kubernetes_clusters
        location                        = var.region
        
        name                            = each.value["name"]
        resource_group_name             = each.value["resource_group_name"]
        dns_prefix                      = each.value["dns_prefix"]
        
        dynamic "default_node_pool" {
        
            for_each = each.value.default_node_pool
            content{
                name        = default_node_pool.value.name
                node_count  = default_node_pool.value.node_count
                vm_size     = default_node_pool.value.vm_size

            }
        }

        identity {
            type = "SystemAssigned"
        }
        
        depends_on = [azurerm_resource_group.resource_groups, azurerm_subnet.subnets]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
#*/