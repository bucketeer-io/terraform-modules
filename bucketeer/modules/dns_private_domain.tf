resource "google_dns_managed_zone" "private_dns" {
  depends_on  = [google_compute_network.network]
  name        = replace(var.dns_private_name, ".", "-")
  dns_name    = "${var.dns_private_name}."
  description = "${var.dns_private_name} DNS private zone"
  project     = var.gcp_project

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.network.self_link
    }
  }
}
