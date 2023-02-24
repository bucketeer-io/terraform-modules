locals {
  services = [
    "appengine.googleapis.com",
    "bigquery.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "pubsub.googleapis.com",
    # "redis.googleapis.com ",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com"
  ]
}

resource "google_project_service" "services" {
  for_each           = toset(local.services)
  project            = var.gcp_project
  service            = each.value
  disable_on_destroy = false
}
