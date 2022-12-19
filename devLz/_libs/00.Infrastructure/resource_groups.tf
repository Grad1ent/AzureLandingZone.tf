module "cmdb" {
    source = "../../cmdb"
}

resource "azurerm_resource_group" "resource_groups" {

  for_each = toset(module.cmdb.resoure_group_names)
    location = module.cmdb.region
    name = each.value
    tags = module.cmdb.tags

}