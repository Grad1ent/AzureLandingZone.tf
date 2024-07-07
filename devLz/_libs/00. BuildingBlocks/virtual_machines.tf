#
# Linux
#
resource "azurerm_virtual_machine" "virtual_machines_linux" {

    for_each = var.virtual_machines_linux
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        vm_size                 = each.value["vm_size"]
        network_interface_ids   = [azurerm_network_interface.network_interface_cards[each.value["network_interface"]].id]
        
        dynamic "storage_image_reference" {
        
            for_each = each.value.storage_image_reference
            content{
                publisher                       = storage_image_reference.value.publisher
                offer                           = storage_image_reference.value.offer
                sku                             = storage_image_reference.value.sku
                version                         = storage_image_reference.value.version
            }
        }

        dynamic "storage_os_disk" {
        
            for_each = each.value.storage_os_disk
            content{
                name                            = storage_os_disk.value.name
                caching                         = storage_os_disk.value.caching
                create_option                   = storage_os_disk.value.create_option
                managed_disk_type               = storage_os_disk.value.managed_disk_type
            }
        }

        dynamic "os_profile" {
        
            for_each = each.value.os_profile
            content{
                computer_name                   = os_profile.value.computer_name
                admin_username                  = os_profile.value.admin_username
                admin_password                  = os_profile.value.admin_password
            }
        }
        
        dynamic "os_profile_linux_config" {
        
            for_each = each.value.os_profile_linux_config
            content{
                disable_password_authentication = os_profile_linux_config.value.disable_password_authentication
            }
        }
        
        depends_on = [azurerm_resource_group.resource_groups, azurerm_network_interface.network_interface_cards]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}

#
# Windows
#
resource "azurerm_virtual_machine" "virtual_machines_windows" {

    for_each = var.virtual_machines_windows
        location                = var.region
        
        name                    = each.value["name"]
        resource_group_name     = each.value["resource_group_name"]
        vm_size                 = each.value["vm_size"]
        network_interface_ids   = [azurerm_network_interface.network_interface_cards[each.value["network_interface"]].id]
        
        dynamic "storage_image_reference" {
        
            for_each = each.value.storage_image_reference
            content{
                publisher                       = storage_image_reference.value.publisher
                offer                           = storage_image_reference.value.offer
                sku                             = storage_image_reference.value.sku
                version                         = storage_image_reference.value.version
            }
        }

        dynamic "storage_os_disk" {
        
            for_each = each.value.storage_os_disk
            content{
                name                            = storage_os_disk.value.name
                caching                         = storage_os_disk.value.caching
                create_option                   = storage_os_disk.value.create_option
                managed_disk_type               = storage_os_disk.value.managed_disk_type
            }
        }

        dynamic "os_profile" {
        
            for_each = each.value.os_profile
            content{
                computer_name                   = os_profile.value.computer_name
                admin_username                  = os_profile.value.admin_username
                admin_password                  = os_profile.value.admin_password
            }
        }
        
        dynamic "os_profile_windows_config" {
        
            for_each = each.value.os_profile_windows_config
            content{
                provision_vm_agent = os_profile_windows_config.value.provision_vm_agent
            }
        }
        
        depends_on = [azurerm_resource_group.resource_groups, azurerm_network_interface.network_interface_cards]
        
    lifecycle {
        ignore_changes = [tags]
    }  

}
