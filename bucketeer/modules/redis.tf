resource "google_redis_instance" "non_persistent_redis" {
  depends_on = [google_service_networking_connection.private_service_connection]
  project        = var.gcp_project
  name           = var.non_persistent_redis_name
  tier           = var.non_persistent_redis_tier
  memory_size_gb = var.non_persistent_redis_memory_size_gb

  location_id             = var.non_persistent_redis_location_id
  alternative_location_id = var.non_persistent_redis_alternative_location_id

  authorized_network = google_compute_network.network.self_link
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  redis_version = var.non_persistent_redis_version
  redis_configs = var.non_persistent_redis_configs

  maintenance_policy {
    weekly_maintenance_window {
      day = "WEDNESDAY"
      start_time {
        hours   = 1
        minutes = 0
        nanos   = 0
        seconds = 0
      }
    }
  }
}

resource "google_redis_instance" "persistent_redis" {
  depends_on = [google_service_networking_connection.private_service_connection]
  project        = var.gcp_project
  name           = var.persistent_redis_name
  tier           = var.persistent_redis_tier
  memory_size_gb = var.persistent_redis_memory_size_gb

  location_id             = var.persistent_redis_location_id
  alternative_location_id = var.persistent_redis_alternative_location_id

  authorized_network = google_compute_network.network.self_link
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  redis_version = var.persistent_redis_version
  redis_configs = var.persistent_redis_configs

  maintenance_policy {
    weekly_maintenance_window {
      day = "WEDNESDAY"
      start_time {
        hours   = 1
        minutes = 0
        nanos   = 0
        seconds = 0
      }
    }
  }
}
