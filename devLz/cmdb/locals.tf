locals {
    # Common
    prefix = var.prefix
    region = var.region
 
    # Resource groups
    rg_hub_name = "${var.prefix}Hub"
    rg_spoke_01_name = "${var.prefix}ML"
    rg_spoke_02_name = "${var.prefix}TF"

    resoure_group_names = [
        local.rg_hub_name,
        local.rg_spoke_01_name,
        local.rg_spoke_02_name
    ]

    # VNets
    virtual_netoworks = {
            
        vnet_hub = {
            name = "${var.prefix}HubVnet"
            address_space     = ["10.100.0.0/16"]
            resource_group_name  = local.rg_hub_name
            
            subnets = [{
                            name = "AzureBastionSubnet"
                            address_prefix = "10.100.10.0/24"
                        },{
                            name = "snet_hub_iaas"
                            address_prefix = "10.100.100.0/24"
                        },{
                            name = "snet_hub_paas"
                            address_prefix = "10.100.200.0/24"
                        }]
        },
        vnet_spoke_01 = {
            name = "${var.prefix}MLVnet"
            address_space     = ["10.200.0.0/16"]
            resource_group_name  = local.rg_spoke_01_name
            
            subnets = [{
                            name = "snet_ml_iaas"
                            address_prefix = "10.200.100.0/24"
                        },{
                            name = "snet_ml_paas"
                            address_prefix = "10.200.200.0/24"
                        }]
        }          
    }

    #PIPs
    public_ip_addresses = {

        pip_hub_01 = {
            name = "${var.prefix}HubBastionPip"
            sku = "Standard"
            allocation_method = "Static"
            resource_group_name = local.rg_hub_name
        }
    }
        
    # Tags
    tags = {
        "Data Classification"   = "Internal"
        "Service identifier"    = "Sample data engineering"
        "Service owner"         = "Wojciech Pazdzierkiewicz"
        "Technical contact"     = "wojciech@pazdzierkiewicz.pl"
        "Cost Center"           = "0000"
        "Regulatory Compliance" = "N/A"
    }


}