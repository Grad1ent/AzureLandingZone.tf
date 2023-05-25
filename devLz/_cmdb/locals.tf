locals {
    # Common
    prefix = var.prefix
    region = var.region
 
   # Tags
    tags = {
        "Data Classification"   = "Internal"
        "Service identifier"    = "Massive data engineering"
        "Service owner"         = "Wojciech Pazdzierkiewicz"
        "Technical contact"     = "wojciech@pazdzierkiewicz.pl"
        "Cost Center"           = "0000"
        "Regulatory Compliance" = "N/A"
    }

    # Resource groups
    rg_hub_name             = "${var.prefix}${var.hub}"
    rg_spoke_01_name        = "${var.prefix}${var.spoke_01}"
    rg_spoke_02_name        = "${var.prefix}${var.spoke_02}"

    resource_group_names = [
        local.rg_hub_name,
        local.rg_spoke_01_name,
        local.rg_spoke_02_name,
    ]

    # VNets
    virtual_networks = {
            
        vnet_hub = {
            name                = "${var.prefix}${var.hub}Vnet"
            address_space       = ["10.200.0.0/16"]
            resource_group_name = local.rg_hub_name            
        },
        vnet_spoke_01 = {
            name                = "${var.prefix}${var.spoke_01}Vnet"
            address_space       = ["10.210.0.0/16"]
            resource_group_name = local.rg_spoke_01_name            
        },          
        vnet_spoke_02 = {
            name                = "${var.prefix}${var.spoke_02}Vnet"
            address_space       = ["10.220.0.0/16"]
            resource_group_name = local.rg_spoke_02_name            
        }   

    }

    # Subnets
    subnets = {
            
        snet_hub_bastion = {
            virtual_network_name    = local.virtual_networks.vnet_hub.name
            resource_group_name     = local.virtual_networks.vnet_hub.resource_group_name

            name                = "AzureBastionSubnet"
            address_prefixes    = ["10.200.10.0/24"]
            nsg                 = "nsg_hub_bastion"
            delegations         = []
        },
        snet_hub_iaas = {
            virtual_network_name    = local.virtual_networks.vnet_hub.name
            resource_group_name     = local.virtual_networks.vnet_hub.resource_group_name

            name                = "${var.prefix}${var.hub}IaasSnet"
            address_prefixes    = ["10.200.100.0/24"]
            nsg                 = "nsg_hub_iaas"
            delegations         = []
        },
        snet_hub_paas = {
            virtual_network_name    = local.virtual_networks.vnet_hub.name
            resource_group_name     = local.virtual_networks.vnet_hub.resource_group_name

            name                = "${var.prefix}${var.hub}PaasSnet"
            address_prefixes    = ["10.200.200.0/24"]
            nsg                 = "nsg_hub_paas"
            delegations         = []
        },

        snet_spoke_01_iaas = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_01.name
            resource_group_name     = local.virtual_networks.vnet_spoke_01.resource_group_name

            name                = "${var.prefix}${var.spoke_01}IaasSnet"
            address_prefixes    = ["10.210.100.0/24"]
            nsg                 = "nsg_spoke_01_iaas"
            delegations         = []
        },
        snet_spoke_01_paas = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_01.name
            resource_group_name     = local.virtual_networks.vnet_spoke_01.resource_group_name

            name                = "${var.prefix}${var.spoke_01}PaasSnet"
            address_prefixes    = ["10.210.200.0/24"]
            nsg                 = "nsg_spoke_01_paas"
            delegations         = []
        },

        snet_spoke_02_iaas = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_02.name
            resource_group_name     = local.virtual_networks.vnet_spoke_02.resource_group_name

            name                = "${var.prefix}${var.spoke_02}IaasSnet"
            address_prefixes    = ["10.220.100.0/24"]
            nsg                 = "nsg_spoke_02_iaas"
            delegations         = []
        },
        snet_spoke_02_paas = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_02.name
            resource_group_name     = local.virtual_networks.vnet_spoke_02.resource_group_name

            name                = "${var.prefix}${var.spoke_02}PaasSnet"
            address_prefixes    = ["10.220.200.0/24"]
            nsg                 = "nsg_spoke_02_paas"
            delegations         = []
        },
       snet_spoke_02_adb_private = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_02.name
            resource_group_name     = local.virtual_networks.vnet_spoke_02.resource_group_name

            name                = "${var.prefix}${var.spoke_02}AdbPrivateSnet"
            address_prefixes    = ["10.220.210.0/24"]
            nsg                 = "nsg_spoke_02_adb_private"
            delegations         = [{
                                    name = "Microsoft.Databricks/workspaces"
                                    actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
                                }]
        },
        snet_spoke_02_adb_public = {
            virtual_network_name    = local.virtual_networks.vnet_spoke_02.name
            resource_group_name     = local.virtual_networks.vnet_spoke_02.resource_group_name

            name                = "${var.prefix}${var.spoke_02}AdbPublicSnet"
            address_prefixes    = ["10.220.220.0/24"]
            nsg                 = "nsg_spoke_02_adb_public"
            delegations         = [{
                                    name = "Microsoft.Databricks/workspaces"
                                    actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
                                }]
        }
            
    }

    # Peers
    virtual_network_peerings = {

        peer_hub_spoke_01 = {
            name                = "${var.prefix}${var.spoke_01}VnetPeer"
            resource_group_name = local.rg_hub_name
            src_vnet            = "vnet_hub"
            dst_vnet            = "vnet_spoke_01"

        },
        peer_hub_spoke_02 = {
            name                = "${var.prefix}${var.spoke_02}VnetPeer"
            resource_group_name = local.rg_hub_name
            src_vnet            = "vnet_hub"
            dst_vnet            = "vnet_spoke_02"

        },
        peer_spoke_01_hub = {
            name                = "${var.prefix}${var.hub}VnetPeer"
            resource_group_name = local.rg_spoke_01_name
            src_vnet            = "vnet_spoke_01"
            dst_vnet            = "vnet_hub"
        },
        peer_spoke_02_hub = {
            name                = "${var.prefix}${var.hub}VnetPeer"
            resource_group_name = local.rg_spoke_02_name
            src_vnet            = "vnet_spoke_02"
            dst_vnet            = "vnet_hub"
        }

    }

    # NSGs
    network_security_groups = {

        #Hub
        nsg_hub_bastion = {
            name                = "${var.prefix}${var.hub}BastionSnetNsg"
            resource_group_name = local.rg_hub_name

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
        nsg_hub_iaas = {
            name                = "${var.prefix}${var.hub}IaasSnetNsg"
            resource_group_name = local.rg_hub_name

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
        nsg_hub_paas = {
            name                = "${var.prefix}${var.hub}PaasSnetNsg"
            resource_group_name = local.rg_hub_name

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

        #Spoke 01
        nsg_spoke_01_iaas = {
            name                = "${var.prefix}${var.spoke_01}IaasSnetNsg"
            resource_group_name = local.rg_spoke_01_name

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
        nsg_spoke_01_paas = {
            name                = "${var.prefix}${var.spoke_01}PaasSnetNsg"
            resource_group_name = local.rg_spoke_01_name

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

        #Spoke 02
        nsg_spoke_02_adb_private = {
            name                = "${var.prefix}${var.spoke_02}AdbPrivateSnetNsg"
            resource_group_name = local.rg_spoke_02_name

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
        nsg_spoke_02_adb_public = {
            name                = "${var.prefix}${var.spoke_02}AdbPublicSnetNsg"
            resource_group_name = local.rg_spoke_02_name

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
        nsg_spoke_02_iaas = {
            name                = "${var.prefix}${var.spoke_02}IaasSnetNsg"
            resource_group_name = local.rg_spoke_02_name

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
        nsg_spoke_02_paas = {
            name                = "${var.prefix}${var.spoke_02}PaasSnetNsg"
            resource_group_name = local.rg_spoke_02_name

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

    #Private DNS zones
    private_dns_zones = {

        dns_01 = {
            name                            = "privatelink.file.core.windows.net"
            resource_group_name             = local.rg_spoke_02_name
            vnet                            = "vnet_spoke_02"
            vnet_link_name                  = "${var.prefix}${var.spoke_02}FileDnsLink"
        },
        dns_02 = {
            name                            = "privatelink.blob.core.windows.net"
            resource_group_name             = local.rg_spoke_02_name
            vnet                            = "vnet_spoke_02"
            vnet_link_name                  = "${var.prefix}${var.spoke_02}BlobDnsLink"
        },
        dns_03 = {
            name                            = "privatelink.vaultcore.azure.net"
            resource_group_name             = local.rg_spoke_02_name
            vnet                            = "vnet_spoke_02"
            vnet_link_name                  = "${var.prefix}${var.spoke_02}KvDnsLink"
        },
        dns_04 = {
            name                            = "privatelink.azurecr.io"
            resource_group_name             = local.rg_spoke_02_name
            vnet                            = "vnet_spoke_02"
            vnet_link_name                  = "${var.prefix}${var.spoke_02}CregDnsLink"
        },
        dns_05 = {
            name                            = "privatelink.api.azureml.ms"
            resource_group_name             = local.rg_spoke_02_name
            vnet                            = "vnet_spoke_02"
            vnet_link_name                  = "${var.prefix}${var.spoke_02}AmlDnsLink"
        }
    }

    # Private endpoints
    private_endpoints_st_file = {

        pep_02 = {
            name                            = "${var.prefix}${var.spoke_02}StFilePep"
            resource_group_name             = local.rg_spoke_02_name
            subnet                          = "snet_spoke_02_paas"

            psc_name                        = "${var.prefix}${var.spoke_02}StFilePsc"
            psc_resource                    = "storage_account_02"
            psc_subresource_names           = ["file"]
            psc_is_manual_connection        = "false"

            dns_group_name                  = "${var.prefix}${var.spoke_02}StFileDns"
            dns_zone                        = "dns_01"
        }

    }

    private_endpoints_st_blob = {

        pep_02 = {
            name                            = "${var.prefix}${var.spoke_02}StBlobPep"
            resource_group_name             = local.rg_spoke_02_name
            subnet                          = "snet_spoke_02_paas"

            psc_name                        = "${var.prefix}${var.spoke_02}StBlobPsc"
            psc_resource                    = "storage_account_02"
            psc_subresource_names           = ["blob"]
            psc_is_manual_connection        = "false"

            dns_group_name                  = "${var.prefix}${var.spoke_02}StBlobDns"
            dns_zone                        = "dns_02"
        }

    }

    private_endpoints_kv = {

        pep_02 = {
            name                            = "${var.prefix}${var.spoke_02}KvPep"
            resource_group_name             = local.rg_spoke_02_name
            subnet                          = "snet_spoke_02_paas"

            psc_name                        = "${var.prefix}${var.spoke_02}KvPsc"
            psc_resource                    = "key_vault_02"
            psc_subresource_names           = ["vault"]
            psc_is_manual_connection        = "false"

            dns_group_name                  = "${var.prefix}${var.spoke_02}KvDns"
            dns_zone                        = "dns_03"
        }

    }

    private_endpoints_creg = {

        pep_02 = {
            name                            = "${var.prefix}${var.spoke_02}CregPep"
            resource_group_name             = local.rg_spoke_02_name
            subnet                          = "snet_spoke_02_paas"

            psc_name                        = "${var.prefix}${var.spoke_02}CregPsc"
            psc_resource                    = "container_registry_02"
            psc_subresource_names           = ["registry"]
            psc_is_manual_connection        = "false"

            dns_group_name                  = "${var.prefix}${var.spoke_02}CregDns"
            dns_zone                        = "dns_04"
        }

    }

    private_endpoints_aml = {

        pep_02 = {
            name                            = "${var.prefix}${var.spoke_02}AmlPep"
            resource_group_name             = local.rg_spoke_02_name
            subnet                          = "snet_spoke_02_paas"

            psc_name                        = "${var.prefix}${var.spoke_02}AmlPsc"
            psc_resource                    = "aml_01"
            psc_subresource_names           = ["amlworkspace"]
            psc_is_manual_connection        = "false"

            dns_group_name                  = "${var.prefix}${var.spoke_02}CregDns"
            dns_zone                        = "dns_05"
        }

    }

    # PIPs
    public_ip_addresses = {

        pip_hub_01 = {
            name                    = "${var.prefix}${var.hub}BastionPip"
            sku                     = "Standard"
            allocation_method       = "Static"
            ddos_protection_mode    = "VirtualNetworkInherited"
            resource_group_name     = local.rg_hub_name
        }
    }
 
    # Bastion
    bastion_hosts = {

        bas_hub = {
            name                = "${var.prefix}${var.hub}Bastion"
            sku                 = "Standard"
            pip                 = "pip_hub_01"
            #vnet                = "vnet_hub"
            snet                = "snet_hub_bastion"
            resource_group_name = local.rg_hub_name
        }

    }

    # Network interace cards
    network_interface_cards = {

        nic_01 = {
            name                            = "${var.prefix}${var.spoke_01}Nic"
            resource_group_name             = local.rg_spoke_01_name

            ip_configuration = [{
                name                          = "ipconfig1"
                subnet                        = "snet_spoke_01_iaas"
                private_ip_address_allocation = "Dynamic"
            }]
        }
    }
    
    # Virtual machines
    virtual_machines = {

        vm_01 = {
            name                            = "${var.prefix}${var.spoke_01}Vm"
            vm_size                         = "Standard_B2ms"
            network_interface               = "nic_01"

            resource_group_name             = local.rg_spoke_01_name
            
            storage_image_reference = [{
                publisher           = "Canonical"
                offer               = "0001-com-ubuntu-server-focal"
                sku                 = "20_04-lts-gen2"
                version             = "latest"
            }]

            storage_os_disk = [{
                name                = "${var.prefix}${var.spoke_01}VmOsDisk"
                caching             = "ReadWrite"
                create_option       = "FromImage"
                managed_disk_type   = "Standard_LRS"
            }]

            os_profile = [{
                computer_name       = "devopshost"
                admin_username      = "devadmin"
                admin_password      = "devP@ssw0rd"
            }]

            os_profile_linux_config = [{
                disable_password_authentication = "false"
            }]

        }
    }     

    # Application insights
    application_insights = {

        application_insights_02 = {
            name                            = "${var.prefix}${var.spoke_02}AppIn"
            application_type                = "web"
            resource_group_name             = local.rg_spoke_02_name
        }
    }

    # Container registries
    container_registries = {

        container_registry_02 = {
            name                            = "${var.prefix}${var.spoke_02}Creg"
            sku                             = "Premium"
            resource_group_name             = local.rg_spoke_02_name
            admin_enabled                   = "true"
        }
    }

    # Key vaults
    key_vaults = {

        key_vault_02 = {
            name                            = "${var.prefix}${var.spoke_02}Kv"
            sku_name                        = "standard"
            resource_group_name             = local.rg_spoke_02_name
            purge_protection_enabled        = "false"
        }
    }

    # Storage accounts
    storage_accounts = {

        storage_account_02 = {
            name                            = lower("${var.prefix}${var.spoke_02}st")
            resource_group_name             = local.rg_spoke_02_name
            account_tier                    = "Standard"
            account_replication_type        = "GRS"
        }
    }

    # Databricks
    databricks_workspaces = {

        adb_01 = {
            name                            = "${var.prefix}${var.spoke_02}Adb"
            sku                             = "standard"
            resource_group_name             = local.rg_spoke_02_name
            managed_resource_group_name     = "${local.rg_spoke_02_name}tmp"
            public_network_access_enabled   = "true"

            custom_parameters = [{
                vnet                = "vnet_spoke_02"
                private_subnet      = "snet_spoke_02_adb_private"
                public_subnet       = "snet_spoke_02_adb_public"
                
                private_subnet_name = local.subnets.snet_spoke_02_adb_private.name
                public_subnet_name  = local.subnets.snet_spoke_02_adb_public.name
                
            }]
        }
    }

    #Azure MLs
    machine_learning_workspaces = {

        aml_01 = {
            name                            = "${var.prefix}${var.spoke_02}Aml"
            resource_group_name             = local.rg_spoke_02_name
            application_insights            = "application_insights_02"
            container_registry              = "container_registry_02"
            storage_account                 = "storage_account_02"
            key_vault                       = "key_vault_02"
            public_network_access_enabled   = "true"

            ci_name                         = "${var.prefix}${var.spoke_02}AmlCi"
            ci_size                         = "Standard_DS11_v2"
            ci_subnet                       = "snet_spoke_02_iaas"

        }

    }
    
}