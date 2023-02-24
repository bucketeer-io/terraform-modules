resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.gcp_project
  auto_create_subnetworks = "false"
}

resource "google_compute_global_address" "private_service_range" {
  depends_on    = [google_compute_network.network]
  name          = var.network_private_service_range_name
  project       = var.gcp_project
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.network_private_service_range_prefix_length
  network       = google_compute_network.network.self_link
}

resource "google_service_networking_connection" "private_service_connection" {
  depends_on = [
    google_compute_network.network,
    google_compute_global_address.private_service_range,
  ]
  network                 = google_compute_network.network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_range.name]
}

resource "google_compute_subnetwork" "subnet" {
  depends_on    = [google_compute_network.network]
  name          = var.network_subnetwork_name
  project       = var.gcp_project
  region        = var.network_region
  network       = var.network_name
  ip_cidr_range = var.network_ip_cidr_range

  secondary_ip_range {
    range_name    = var.network_pods_range_name
    ip_cidr_range = var.network_pods_ip_cidr_range
  }

  secondary_ip_range {
    range_name    = var.network_svc_range_name
    ip_cidr_range = var.network_svc_ip_cidr_range
  }

  lifecycle {
    ignore_changes = [network]
  }
}
