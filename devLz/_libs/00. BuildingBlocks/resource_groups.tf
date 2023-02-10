resource "azurerm_resource_group" "resource_groups" {

  for_each = toset(var.resource_group_names)
    location  = var.region

    name      = each.value
    tags      = var.tags
    
  lifecycle {
        ignore_changes = [tags]
  }

}