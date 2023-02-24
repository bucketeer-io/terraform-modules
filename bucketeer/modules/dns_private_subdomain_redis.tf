resource "google_dns_record_set" "non_persistent_redis" {
  depends_on   = [
    google_dns_managed_zone.private_dns,
    google_redis_instance.non_persistent_redis
  ]
  name         = "${var.dns_private_non_persistent_redis_name}."
  type         = "A"
  ttl          = var.dns_private_non_persistent_redis_ttl
  rrdatas      = [google_redis_instance.non_persistent_redis.host]
  managed_zone = var.dns_private_managed_zone_name
  project      = var.gcp_project
}

resource "google_dns_record_set" "persistent_redis" {
  depends_on   = [
    google_dns_managed_zone.private_dns,
    google_redis_instance.non_persistent_redis
  ]
  name         = "${var.dns_private_persistent_redis_name}."
  type         = "A"
  ttl          = var.dns_private_persistent_redis_ttl
  rrdatas      = [google_redis_instance.persistent_redis.host]
  managed_zone = var.dns_private_managed_zone_name
  project      = var.gcp_project
}
