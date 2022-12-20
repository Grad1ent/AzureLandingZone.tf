module "cmdb" {
    source = "../../cmdb"
}

resource "azurerm_resource_group" "resource_groups" {

  for_each = toset(module.cmdb.resoure_group_names)
    name = each.value
    tags = module.cmdb.tags
    location = module.cmdb.region

  lifecycle {
        ignore_changes = [tags]
  }
}