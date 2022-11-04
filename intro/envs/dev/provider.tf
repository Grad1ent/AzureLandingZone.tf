terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.19.1"
    }
  }

  required_version = ">= 1.1.0"
/*
  backend "azurerm" {
      resource_group_name  = "devAutomation"
      storage_account_name = "stterraform"
      container_name       = "tfstate"
      key                  = "samples/intro/infra.terraform.tfstate"
  }
*/
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
