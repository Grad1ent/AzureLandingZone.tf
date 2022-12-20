resource "azurerm_network_security_group" "network_security_groups"{

    for_each = module.cmdb.network_security_groups
        location = module.cmdb.region
        
        name = each.value["name"]
        resource_group_name = each.value["resource_group_name"]
        
        dynamic "security_rule" {
        
            for_each = each.value.security_rules
            content{
                access                      = security_rule.value.access
                destination_address_prefix  = security_rule.value.destination_address_prefix
                destination_port_range      = security_rule.value.destination_port_range
                direction                   = security_rule.value.direction
                name                        = security_rule.value.name
                priority                    = security_rule.value.priority
                protocol                    = security_rule.value.protocol
                source_address_prefix       = security_rule.value.source_address_prefix
                source_port_range           = security_rule.value.source_port_range
            }
        }

    lifecycle {
        ignore_changes = [tags]
    }

}