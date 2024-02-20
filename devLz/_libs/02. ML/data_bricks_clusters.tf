#/*
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on = [var.databricks_workspaces]
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [var.databricks_workspaces]
}

resource "databricks_cluster" "databricks_clusters" {
  for_each = var.databricks_clusters
    cluster_name            = each.value["cluster_name"]
    spark_version           = data.databricks_spark_version.latest_lts.id
    node_type_id            = data.databricks_node_type.smallest.id
    autotermination_minutes = each.value["autotermination_minutes"]

    dynamic autoscale {
        for_each = each.value.autoscale
            content{
                min_workers = autoscale.value.min_workers
                max_workers = autoscale.value.max_workers
            }
    }

    depends_on = [var.databricks_workspaces]
}
#*/