output "virtual_machines" {
  value = azurerm_virtual_machine.virtual_machines
}

output "databricks_workspaces" {
  value = azurerm_databricks_workspace.databricks_workspaces
}

output "machine_learning_workspaces" {
  value = azurerm_machine_learning_workspace.machine_learning_workspaces
}
/*
output "kubernetes_clusters" {
  value = azurerm_kubernetes_cluster.kubernetes_clusters
}
*/
/*
output "data_factories" {
  value = azurerm_data_factory.data_factories
}
*/
/*
output "data_lakes" {
  value = azurerm_storage_data_lake_gen2_filesystem.data_lakes
}
*/
/*
output "synapse_workspaces" {
  value = azurerm_synapse_workspace.synapse_workspaces
}
*/