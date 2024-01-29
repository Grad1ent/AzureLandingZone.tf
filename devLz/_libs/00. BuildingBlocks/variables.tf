data "azurerm_client_config" "current" {}

variable "region" {}
variable "tags" {}

variable "bastion_hosts" {}
variable "network_security_groups" {}
variable "public_ip_addresses" {}
variable "resource_group_names" {}
variable "virtual_network_peerings" {}
variable "virtual_networks" {}
variable "subnets" {}
variable "network_interface_cards" {}
variable "private_dns_zones" {}
variable "private_endpoints_kv" {}
variable "private_endpoints_st_blob" {}
variable "private_endpoints_st_file" {}
variable "private_endpoints_creg" {}
variable "private_endpoints_aml" {}
variable "virtual_machines" {}
variable "application_insights" {}
variable "container_registries" {}
variable "storage_accounts" {}
variable "key_vaults" {}
variable "databricks_workspaces" {}
variable "machine_learning_workspaces" {}
variable "machine_learning_compute_instances" {}
variable "machine_learning_compute_clusters" {}
variable "machine_learning_inference_clusters" {}
variable "kubernetes_clusters" {}
variable "data_factories" {}