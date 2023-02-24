# Create DNS Zones for the api and the admin console

resource "google_dns_managed_zone" "dns" {
  depends_on  = [google_project_service.services]
  name        = replace(var.dns_name, ".", "-")
  dns_name    = "${var.dns_name}."
  description = "${var.dns_name} DNS Zone"
  project     = var.gcp_project
}

resource "google_compute_global_address" "dns" {
  depends_on = [
    google_project_service.services,
    google_dns_managed_zone.dns
  ]
  count   = var.dns_address == "" && var.dns_is_global ? 1 : 0
  name    = replace(var.dns_admin_console_name, ".", "-")
  project = var.gcp_project
}

resource "google_compute_address" "dns" {
  depends_on = [
    google_project_service.services,
    google_dns_managed_zone.dns
  ]
  count   = var.dns_address == "" && !var.dns_is_global ? 1 : 0
  name    = replace(var.dns_admin_console_name, ".", "-")
  project = var.gcp_project
  region  = var.dns_region
}

resource "google_dns_record_set" "dns" {
  depends_on = [
    google_compute_global_address.dns,
    google_compute_address.dns,
  ]
  name         = "${var.dns_admin_console_name}."
  type         = "A"
  ttl          = var.dns_ttl
  rrdatas      = [var.dns_address == "" ? join("", google_compute_global_address.dns.*.address, google_compute_address.dns.*.address) : var.dns_address]
  managed_zone = var.dns_managed_zone_name
  project      = var.gcp_project
}
