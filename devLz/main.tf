data "azurerm_client_config" "current" {}

module "Infrastructure" {
    source = "./_libs/00.Infrastructure"
}


