data "azurerm_client_config" "current" {}

module "main" {
    source = "./_lib"

    #
    # Hub
    #
    rg_hub_name = "adoHub"

    vnet_hub_name = "adoHubVnet"
    vnet_hub_address_space = ["10.100.0.0/16"]

    snet_hub_bastion_name = "AzureBastionSubnet"
    snet_hub_bastion_address_prefix = "10.100.10.0/24"

    snet_hub_name = "adoHubSnet"
    snet_hub_address_prefix = "10.100.100.0/24"

    #
    # Spoke 1
    #
    rg_spoke_01_name = "adoSpoke01"

    vnet_spoke_01_name = "adoSpoke01Vnet"
    vnet_spoke_01_address_space = ["10.101.0.0/16"]

    snet_spoke_01_name = "adoSpoke01Snet"
    snet_spoke_01_address_prefix = "10.101.100.0/24"
}