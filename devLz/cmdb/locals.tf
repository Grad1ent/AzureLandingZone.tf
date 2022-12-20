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
                            name = "IaasSnet"
                            address_prefix = "10.100.100.0/24"
                        },{
                            name = "PaasSnet"
                            address_prefix = "10.100.200.0/24"
                        }]
        },
        vnet_spoke_01 = {
            name = "${var.prefix}MLVnet"
            address_space     = ["10.200.0.0/16"]
            resource_group_name  = local.rg_spoke_01_name
            
            subnets = [{
                            name = "IaasSnet"
                            address_prefix = "10.200.100.0/24"
                        },{
                            name = "PaasSnet"
                            address_prefix = "10.200.200.0/24"
                        }]
        }          
    }

    #NSGs
    network_security_groups = {

        nsg_hub_bastion = {
            name = "${var.prefix}HubBastionSnetNsg"
            resource_group_name  = local.rg_hub_name

            security_rules = [{
                access                      = "Allow"
                destination_address_prefix  = "*"
                destination_port_range      = "443"
                direction                   = "Inbound"
                name                        = "AllowHttpsInbound"
                priority                    = 100
                protocol                    = "Tcp"
                source_address_prefix       = "Internet"
                source_port_range           = "*"                
            },            
            {
                access                      = "Allow"
                destination_address_prefix  = "*"
                destination_port_range      = "443"
                direction                   = "Inbound"
                name                        = "AllowGatewayManagerInbound"
                priority                    = 110
                protocol                    = "Tcp"
                source_address_prefix       = "GatewayManager"
                source_port_range           = "*"                
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "*"
                destination_port_range      = "443"
                direction                   = "Inbound"
                name                        = "AllowAzureLoadBalancerInbound"
                priority                    = 120
                protocol                    = "Tcp"
                source_address_prefix       = "AzureLoadBalancer"
                source_port_range           = "*"
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "8080"
                direction                   = "Inbound"
                name                        = "AllowBastionHostCommunication_1"
                priority                    = 130
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"                
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "5701"
                direction                   = "Inbound"
                name                        = "AllowBastionHostCommunication_2"
                priority                    = 140
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"                
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "22"
                direction                   = "Outbound"
                name                        = "AllowSshOutbound"
                priority                    = 100
                protocol                    = "*"
                source_address_prefix       = "*"
                source_port_range           = "*"                
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "3389"
                direction                   = "Outbound"
                name                        = "AllowRdpOutbound"
                priority                    = 110
                protocol                    = "*"
                source_address_prefix       = "*"
                source_port_range           = "*"                
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "AzureCloud"
                destination_port_range      = "443"
                direction                   = "Outbound"
                name                        = "AllowAzureCloudOutbound"
                priority                    = 120
                protocol                    = "Tcp"
                source_address_prefix       = "*"
                source_port_range           = "*"
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "8080"
                direction                   = "Outbound"
                name                        = "AllowBastionCommunication_1"
                priority                    = 130
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "5701"
                direction                   = "Outbound"
                name                        = "AllowBastionCommunication_2"
                priority                    = 140
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"
            },
            {
                access                      = "Allow"
                destination_address_prefix  = "Internet"
                destination_port_range      = "80"
                direction                   = "Outbound"
                name                        = "AllowGetSessionInformation"
                priority                    = 150
                protocol                    = "*"
                source_address_prefix       = "*"
                source_port_range           = "*"                
            }]
        },
        nsg_02 = {
            name = "${var.prefix}HubIaasSnetNsg"
            resource_group_name  = local.rg_hub_name

            security_rules = [{
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "*"
                direction                   = "Outbound"
                name                        = "AllowVnetOutBoundCustom"
                priority                    = 4096
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"                      
            }]
        },
        nsg_03 = {
            name = "${var.prefix}HubPaasSnetNsg"
            resource_group_name  = local.rg_hub_name

            security_rules = [{
                access                      = "Allow"
                destination_address_prefix  = "VirtualNetwork"
                destination_port_range      = "*"
                direction                   = "Outbound"
                name                        = "AllowVnetOutBoundCustom"
                priority                    = 4096
                protocol                    = "*"
                source_address_prefix       = "VirtualNetwork"
                source_port_range           = "*"                      
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