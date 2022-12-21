data "azurerm_client_config" "current" {}

module "Infrastructure" {
    source = "./_libs/00. Infrastructure"
}

module "ML" {
    source = "./_libs/01. ML"
}