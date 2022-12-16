resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "devHub"
}
resource "azurerm_bastion_host" "res-1" {
  location            = "westeurope"
  name                = "devHubBastion"
  resource_group_name = "devHub"
  sku                 = "Standard"
  ip_configuration {
    name                 = "IpConf"
    public_ip_address_id = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/publicIPAddresses/devHubBastionPip"
    subnet_id            = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/virtualNetworks/devHubVnet/subnets/AzureBastionSubnet"
  }
  depends_on = [
    azurerm_public_ip.res-15,
    # One of azurerm_subnet.res-17,azurerm_subnet_network_security_group_association.res-18 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_security_group" "res-2" {
  location            = "westeurope"
  name                = "devHubBastionSnetNsg"
  resource_group_name = "devHub"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-3" {
  access                      = "Allow"
  destination_address_prefix  = "AzureCloud"
  destination_port_range      = "443"
  direction                   = "Outbound"
  name                        = "AllowAzureCloudOutbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = "devHub"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-4" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowAzureLoadBalancerInbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = "devHub"
  source_address_prefix       = "AzureLoadBalancer"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-5" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "8080"
  direction                   = "Outbound"
  name                        = "AllowBastionCommunication_1"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 130
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-6" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "5701"
  direction                   = "Outbound"
  name                        = "AllowBastionCommunication_2"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 140
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-7" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "8080"
  direction                   = "Inbound"
  name                        = "AllowBastionHostCommunication_1"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 130
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-8" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "5701"
  direction                   = "Inbound"
  name                        = "AllowBastionHostCommunication_2"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 140
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-9" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowGatewayManagerInbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = "devHub"
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-10" {
  access                      = "Allow"
  destination_address_prefix  = "Internet"
  destination_port_range      = "80"
  direction                   = "Outbound"
  name                        = "AllowGetSessionInformation"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 150
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-11" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowHttpsInbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = "devHub"
  source_address_prefix       = "Internet"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-12" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "3389"
  direction                   = "Outbound"
  name                        = "AllowRdpOutbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 110
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-13" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "22"
  direction                   = "Outbound"
  name                        = "AllowSshOutbound"
  network_security_group_name = "devHubBastionSnetNsg"
  priority                    = 100
  protocol                    = "*"
  resource_group_name         = "devHub"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_group" "res-14" {
  location            = "westeurope"
  name                = "devHubSnetNsg"
  resource_group_name = "devHub"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_public_ip" "res-15" {
  allocation_method   = "Static"
  location            = "westeurope"
  name                = "devHubBastionPip"
  resource_group_name = "devHub"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-16" {
  address_space       = ["10.100.0.0/16"]
  location            = "westeurope"
  name                = "devHubVnet"
  resource_group_name = "devHub"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_subnet" "res-17" {
  address_prefixes     = ["10.100.10.0/24"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = "devHub"
  virtual_network_name = "devHubVnet"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-18" {
  network_security_group_id = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/networkSecurityGroups/devHubBastionSnetNsg"
  subnet_id                 = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/virtualNetworks/devHubVnet/subnets/AzureBastionSubnet"
  depends_on = [
    azurerm_network_security_group.res-2,
    azurerm_subnet.res-17,
  ]
}
resource "azurerm_subnet" "res-19" {
  address_prefixes     = ["10.100.20.0/24"]
  name                 = "GatewaySubnet"
  resource_group_name  = "devHub"
  virtual_network_name = "devHubVnet"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_subnet" "res-20" {
  address_prefixes     = ["10.100.100.0/24"]
  name                 = "devHubSnet"
  resource_group_name  = "devHub"
  virtual_network_name = "devHubVnet"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-21" {
  network_security_group_id = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/networkSecurityGroups/devHubSnetNsg"
  subnet_id                 = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devHub/providers/Microsoft.Network/virtualNetworks/devHubVnet/subnets/devHubSnet"
  depends_on = [
    azurerm_network_security_group.res-14,
    azurerm_subnet.res-20,
  ]
}
resource "azurerm_virtual_network_peering" "res-22" {
  name                      = "devdevopspeer"
  remote_virtual_network_id = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devDevOps/providers/Microsoft.Network/virtualNetworks/devDevOpsVnet"
  resource_group_name       = "devHub"
  virtual_network_name      = "devHubVnet"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
resource "azurerm_virtual_network_peering" "res-23" {
  name                      = "devmlpeer"
  remote_virtual_network_id = "/subscriptions/e82dd30d-3520-4f29-b1e7-1a671e17c4c3/resourceGroups/devML/providers/Microsoft.Network/virtualNetworks/devMLVnet"
  resource_group_name       = "devHub"
  virtual_network_name      = "devHubVnet"
  depends_on = [
    azurerm_virtual_network.res-16,
  ]
}
