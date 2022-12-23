#data "azurerm_client_config" "current" {}

module "Infrastructure" {
    source = "./_libs/00. Infrastructure"
}

module "DevOps" {
    source = "./_libs/01. DevOps"
}

module "ML" {
    source = "./_libs/02. ML"

    virtual_networks = module.Infrastructure.virtual_networks
    network_security_groups = module.Infrastructure.network_security_groups
}
