data "azurerm_client_config" "current" {}

module "main" {
    source = "./_lib"

    #
    # Hub
    #
    rg_hub_name = "devHub"

    vnet_hub_name = "devHubVnet"
    vnet_hub_address_space = ["10.100.0.0/16"]

    snet_hub_bastion_name = "AzureBastionSubnet"
    snet_hub_bastion_address_prefixes = ["10.100.10.0/24"]
    nsg_snet_hub_bastion_name = "devHubBastionSnetNsg"

    snet_hub_name = "devHubSnet"
    snet_hub_address_prefixes = ["10.100.100.0/24"]
    nsg_snet_hub_name = "devHubSnetNsg"

    #
    # Spoke 1
    #
    rg_spoke_01_name = "devSpoke01"

    vnet_spoke_01_name = "devSpoke01Vnet"
    vnet_spoke_01_address_space = ["10.101.0.0/16"]

    snet_spoke_01_name = "devSpoke01Snet"
    snet_spoke_01_address_prefixes = ["10.101.100.0/24"]
    nsg_snet_spoke_01_name = "devSpoke01SnetNsg"
}