module "cmdb" {
    source = "./_cmdb"
}

module "BuildingBlocks" {
    source = "./_libs/00. BuildingBlocks"

    region                      = module.cmdb.region
    tags                        = module.cmdb.tags

    resource_group_names        = module.cmdb.resource_group_names
    bastion_hosts               = module.cmdb.bastion_hosts
    virtual_networks            = module.cmdb.virtual_networks
    virtual_network_peerings    = module.cmdb.virtual_network_peerings
    subnets                     = module.cmdb.subnets
    network_security_groups     = module.cmdb.network_security_groups
    public_ip_addresses         = module.cmdb.public_ip_addresses
    network_interface_cards     = module.cmdb.network_interface_cards
    virtual_machines            = module.cmdb.virtual_machines
    databricks_workspaces       = module.cmdb.databricks_workspaces
    
}

module "DevOps" {
    source = "./_libs/01. DevOps"

    virtual_machines            = module.BuildingBlocks.virtual_machines
    configuration               = module.cmdb.virtual_machines
}

module "ML" {
    source = "./_libs/02. ML"

    databricks_workspaces       = module.BuildingBlocks.databricks_workspaces
    configuration               = module.cmdb.databricks_workspaces
}
