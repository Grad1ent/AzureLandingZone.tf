output "virtual_machines" {
  value = azurerm_virtual_machine.virtual_machines
}

output "databricks_workspaces" {
  value = azurerm_databricks_workspace.databricks_workspaces
}

output "machine_learning_workspaces" {
  value = azurerm_machine_learning_workspace.machine_learning_workspaces
}