terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.19.1"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
      resource_group_name  = "devDevOps"
      storage_account_name = "devdevopstfstates"
      container_name       = "tfstates"
      key                  = "intro/dev/infra.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
