resource "google_dns_record_set" "bucketeer_mysql" {
  depends_on   = [
    google_dns_managed_zone.private_dns,
    google_sql_database_instance.bucketeer_mysql
  ]
  name         = "${var.dns_private_bucketeer_mysql_name}."
  type         = "A"
  ttl          = var.dns_private_bucketeer_mysql_ttl
  rrdatas      = [google_sql_database_instance.bucketeer_mysql.private_ip_address]
  managed_zone = var.dns_private_managed_zone_name
  project      = var.gcp_project
}
