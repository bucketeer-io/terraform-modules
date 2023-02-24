resource "google_sql_database_instance" "bucketeer_mysql" {
  depends_on = [google_service_networking_connection.private_service_connection]
  project             = var.gcp_project
  name                = var.bucketeer_mysql_name
  region              = var.bucketeer_mysql_region
  database_version    = var.bucketeer_mysql_version
  deletion_protection = var.bucketeer_mysql_deletion_protection

  settings {
    tier              = var.bucketeer_mysql_tier
    activation_policy = var.bucketeer_mysql_activation_policy
    availability_type = var.bucketeer_mysql_availability_type
    disk_autoresize   = var.bucketeer_mysql_disk_autoresize
    disk_type         = var.bucketeer_mysql_disk_type

    backup_configuration {
      location           = "asia"
      enabled            = true
      binary_log_enabled = true
      start_time         = var.bucketeer_mysql_backup_configuration_start_time
    }

    maintenance_window {
      day          = 3
      hour         = 1
      update_track = var.bucketeer_mysql_maintenance_window_update_track
    }

    location_preference {
      zone = var.bucketeer_mysql_location
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.network.self_link
    }

    insights_config {
      query_insights_enabled  = true
      query_string_length     = 1024
      record_application_tags = true
      record_client_address   = true
    }
  }
}

resource "google_sql_database" "bucketeer_mysql_database_master" {
  depends_on = [google_sql_database_instance.bucketeer_mysql]
  project    = var.gcp_project
  name       = "master"
  instance   = google_sql_database_instance.bucketeer_mysql.name
  charset    = "utf8mb4"
  collation  = "utf8mb4_bin"
}

resource "google_sql_user" "bucketeer_mysql_user" {
  depends_on = [google_sql_database_instance.bucketeer_mysql]
  project    = var.gcp_project
  name       = var.bucketeer_mysql_user_name
  host       = "%"
  instance   = google_sql_database_instance.bucketeer_mysql.name
  password   = var.bucketeer_mysql_user_password
}
