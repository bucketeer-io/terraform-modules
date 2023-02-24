resource "google_container_node_pool" "services_node_pool" {
  depends_on        = [google_container_cluster.cluster]
  project           = var.gcp_project
  name              = var.services_nodepool_name
  location          = var.services_nodepool_location
  version           = var.cluster_node_version
  cluster           = google_container_cluster.cluster.name
  max_pods_per_node = var.services_nodepool_max_pods_per_node
  provider          = google-beta

  management {
    auto_upgrade = false
  }

  node_config {
    spot            = var.services_nodepool_spot_vm
    machine_type    = var.services_nodepool_machine_type
    labels          = var.services_nodepool_labels
    image_type      = var.cluster_image_type
    disk_size_gb    = var.cluster_disk_size_gb
    local_ssd_count = var.cluster_local_ssd_count

    // Because Terraform doesn't support conditionals in lists.
    oauth_scopes = compact(split(" ", format("%s %s %s %s", join(" ", local.service_auth_scopes), var.services_nodepool_disable_monitoring ? "" : local.monitoring_scope, var.services_nodepool_disable_logging ? "" : local.logging_scope, var.services_nodepool_disable_trace ? "" : local.trace_scope)))

    kubelet_config {
      cpu_manager_policy = "none"
      cpu_cfs_quota      = false
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  autoscaling {
    min_node_count = var.services_nodepool_min_node_count
    max_node_count = var.services_nodepool_max_node_count
  }

  lifecycle {
    ignore_changes = [node_config]
  }

  timeouts {
    create = var.services_nodepool_timeouts_create
    update = var.services_nodepool_timeouts_update
    delete = var.services_nodepool_timeouts_delete
  }
}
