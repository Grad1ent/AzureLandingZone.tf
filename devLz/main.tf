data "azurerm_client_config" "current" {}

module "cmdb" {
    source = "./_cmdb"
}

module "Infrastructure" {
    source = "./_libs/00. Infrastructure"

    region                      = module.cmdb.region
    resource_group_names        = module.cmdb.resource_group_names
    bastion_hosts               = module.cmdb.bastion_hosts
    virtual_networks            = module.cmdb.virtual_networks
    virtual_network_peerings    = module.cmdb.virtual_network_peerings
    subnets                     = module.cmdb.subnets
    network_security_groups     = module.cmdb.network_security_groups
    public_ip_addresses         = module.cmdb.public_ip_addresses
    virtual_machines            = module.cmdb.virtual_machines
    network_interface_cards     = module.cmdb.network_interface_cards
    tags                        = module.cmdb.tags

}

module "DevOps" {
    source = "./_libs/01. DevOps"
}

module "ML" {
    source = "./_libs/02. ML"

    region                      = module.cmdb.region
    virtual_networks            = module.Infrastructure.virtual_networks
    subnets                     = module.Infrastructure.subnets
    databricks_workspaces       = module.cmdb.databricks_workspaces
}
