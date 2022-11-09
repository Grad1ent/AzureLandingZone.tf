#
# General
#
variable "location" {
  type    = string
  default = "westeurope"
}

#
# Hub
#
variable "rg_hub_name" {
  type = string
}

variable "vnet_hub_name" {
  type = string
}

variable "vnet_hub_address_space" {
  type = list(string)
}

variable "snet_hub_bastion_name" {
  type = string
}

variable "snet_hub_bastion_address_prefix" {
  type = string
}

variable "snet_hub_name" {
  type = string
}

variable "snet_hub_address_prefix" {
  type = string
}

#
# Spoke 1
#
variable "rg_spoke_01_name" {
  type = string
}

variable "vnet_spoke_01_name" {
  type = string
}

variable "vnet_spoke_01_address_space" {
  type = list(string)
}

variable "snet_spoke_01_name" {
  type = string
}

variable "snet_spoke_01_address_prefix" {
  type = string
}




