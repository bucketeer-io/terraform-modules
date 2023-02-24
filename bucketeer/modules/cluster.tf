resource "google_container_cluster" "cluster" {
  depends_on = [
    google_compute_subnetwork.subnet,
    google_project_iam_member.host_service_agent_user
  ]
  provider                 = google-beta
  project                  = var.gcp_project
  name                     = var.cluster_name
  location                 = var.cluster_location
  node_locations           = var.cluster_node_locations
  initial_node_count       = 1
  remove_default_node_pool = true

  network    = google_compute_network.network.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  min_master_version = var.cluster_version

  logging_service    = var.cluster_disable_logging ? "none" : "logging.googleapis.com/kubernetes"
  monitoring_service = var.cluster_disable_monitoring ? "none" : "monitoring.googleapis.com/kubernetes"
  enable_legacy_abac = var.cluster_enable_legacy_abac

  vertical_pod_autoscaling {
    enabled = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.network_pods_range_name
    services_secondary_range_name = var.network_svc_range_name
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }

  lifecycle {
    ignore_changes = [initial_node_count, network, subnetwork, master_auth]
  }
}
