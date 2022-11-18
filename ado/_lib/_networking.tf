#
# Hub
#
resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.vnet_hub_name
  address_space       = var.vnet_hub_address_space
  location            = var.location
  resource_group_name = var.rg_hub_name
}

resource "azurerm_subnet" "snet_hub_bastion" {
  name                 = var.snet_hub_bastion_name
  resource_group_name  = var.rg_hub_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = var.snet_hub_bastion_address_prefixes
}

resource "azurerm_subnet" "snet_hub" {
  name                 = var.snet_hub_name
  resource_group_name  = var.rg_hub_name
  virtual_network_name = var.vnet_hub_name
  address_prefixes     = var.snet_hub_address_prefixes
}

#
# Spoke 01
#
resource "azurerm_virtual_network" "vnet_spoke_01" {
  name                = var.vnet_spoke_01_name
  address_space       = var.vnet_spoke_01_address_space
  location            = var.location
  resource_group_name = var.rg_spoke_01_name
}

resource "azurerm_subnet" "snet_spoke_01" {
  name                 = var.snet_spoke_01_name
  resource_group_name  = var.rg_spoke_01_name
  virtual_network_name = var.vnet_spoke_01_name
  address_prefixes     = var.snet_spoke_01_address_prefixes
}

#
# Peering hub <> spoke(s)
#
resource "azurerm_virtual_network_peering" "peer_hub_spoke_01" {
  name                      = "hub-spoke_01"
  resource_group_name       = azurerm_resource_group.rg_hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke_01.id
}

resource "azurerm_virtual_network_peering" "peer_spoke_01_hub" {
  name                      = "spoke_01-hub"
  resource_group_name       = azurerm_resource_group.rg_spoke_01.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke_01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}

#
# NSGs
#
resource "azurerm_network_security_group" "nsg_snet_hub_bastion" {
  name                = var.nsg_snet_hub_bastion_name
  location            = var.location
  resource_group_name = var.rg_hub_name

security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "AllowGatewayManagerInbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "AllowAzureLoadBalancerInbound"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "AllowBastionHostCommunication"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080, 5701"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

security_rule {
    name                       = "AllowSshRdpOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22,3389"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
security_rule {
    name                       = "AllowAzureCloudOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
security_rule {
    name                       = "AllowBastionCommunication"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080, 5701"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
security_rule {
    name                       = "AllowGetSessionInformation"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_hub_bastion" {
  subnet_id                 = azurerm_subnet.snet_hub_bastion.id
  network_security_group_id = azurerm_network_security_group.nsg_snet_hub_bastion.id
}






resource "azurerm_network_security_group" "nsg_snet_hub" {
  name                = var.nsg_snet_hub_name
  location            = var.location
  resource_group_name = var.rg_hub_name
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_hub" {
  subnet_id                 = azurerm_subnet.snet_hub.id
  network_security_group_id = azurerm_network_security_group.nsg_snet_hub.id
}

resource "azurerm_network_security_group" "nsg_snet_spoke_01" {
  name                = var.nsg_snet_spoke_01_name
  location            = var.location
  resource_group_name = var.rg_spoke_01_name
}

resource "azurerm_subnet_network_security_group_association" "ass_nsg_snet_spoke_01" {
  subnet_id                 = azurerm_subnet.snet_spoke_01.id
  network_security_group_id = azurerm_network_security_group.nsg_snet_spoke_01.id
}


