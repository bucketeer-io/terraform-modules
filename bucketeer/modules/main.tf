# terraform {
#   backend "gcs" {}
# }

data "google_compute_network" "network" {
  name    = var.network_name
  project = var.gcp_project
}

data "google_project" "project" {
  project_id = var.gcp_project
}

data "google_compute_default_service_account" "default" {
  project = var.gcp_project
}
