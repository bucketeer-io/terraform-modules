resource "google_compute_global_address" "l7_api" {
  depends_on = [google_dns_managed_zone.dns]
  count   = var.dns_l7_api_address == "" ? 1 : 0
  name    = format("l7-%s", replace(var.dns_l7_api_name, ".", "-"))
  project = var.gcp_project
}

resource "google_dns_record_set" "l7_api" {
  depends_on   = [google_compute_global_address.l7_api]
  name         = "${var.dns_l7_api_name}."
  type         = "A"
  ttl          = var.dns_l7_api_ttl
  rrdatas      = [var.dns_l7_api_address == "" ? join("", google_compute_global_address.l7_api.*.address) : var.dns_l7_api_address]
  managed_zone = var.dns_managed_zone_name
  project      = var.gcp_project
}
