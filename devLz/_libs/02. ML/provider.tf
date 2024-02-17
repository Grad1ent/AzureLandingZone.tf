terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "databricks" {
  # host                        = data.azurerm_databricks_workspace.this.workspace_url
  azure_workspace_resource_id = var.databricks_workspaces[0].id

  # ARM_USE_MSI environment variable is recommended
  azure_use_msi = true
  
}

