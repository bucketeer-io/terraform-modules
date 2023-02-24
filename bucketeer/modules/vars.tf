# Project info

variable "name" {
  type = string
}
variable "gcp_credentials" {
  type = string
}
variable "gcp_storage_project" {
  type = string
}
variable "gcp_project" {
  type = string
}
variable "gcp_region" {
  type = string
}

# Network

variable "network_name" {
  type    = string
  default = "bucketeer-network"
}
variable "network_subnetwork_name" {
  type    = string
  default = "bucketeer-subnetwork"
}
variable "network_region" {
  type    = string
  default = "asia-northeast1"
}
variable "network_ip_cidr_range" {
  type    = string
  default = "10.1.0.0/16"
}
variable "network_pods_range_name" {
  type    = string
  default = "pods-range"
}
variable "network_pods_ip_cidr_range" {
  type    = string
  default = "10.2.0.0/16"
}
variable "network_svc_range_name" {
  type    = string
  default = "svc-range"
}
variable "network_svc_ip_cidr_range" {
  type    = string
  default = "10.3.0.0/16"
}
variable "network_private_service_range_name" {
  type    = string
  default = "private-service-range"
}
variable "network_private_service_range_prefix_length" {
  type    = number
  default = 20
}

# Cluster

variable "cluster_name" {
  type    = string
  default = "bucketeer"
}
variable "cluster_location" {
  type    = string
  default = "asia-northeast1-a"
}
variable "cluster_region" {
  type    = string
  default = "asia-northeast1-a"
}
variable "cluster_version" {
  type    = string
  default = "1.22.17-gke.4000"
}
variable "cluster_node_version" {
  type    = string
  default = "1.22.17-gke.4000"
}
variable "cluster_image_type" {
  type    = string
  default = "COS_CONTAINERD"
}
variable "cluster_disk_size_gb" {
  type    = number
  default = 20
}
variable "cluster_local_ssd_count" {
  type    = string
  default = 0
}
variable "cluster_node_locations" {
  type    = list(string)
  default = []
}
variable "cluster_disable_logging" {
  type    = bool
  default = false
}
variable "cluster_disable_monitoring" {
  type    = bool
  default = false
}
variable "cluster_enable_legacy_abac" {
  type    = bool
  default = true
}

# Cluster Services Node

variable "services_nodepool_name" {
  type    = string
  default = "services-pool"
}
variable "services_nodepool_location" {
  type    = string
  default = "asia-northeast1-a"
}
variable "services_nodepool_max_pods_per_node" {
  type    = number
  default = 110
}
variable "services_nodepool_min_node_count" {
  type    = number
  default = 1
}
variable "services_nodepool_max_node_count" {
  type    = number
  default = 1
}
variable "services_nodepool_spot_vm" {
  type    = bool
  default = true
}
variable "services_nodepool_machine_type" {
  type    = string
  default = "n1-highcpu-4"
}
variable "services_nodepool_labels" {
  type    = map(string)
  default = { pool-type = "services" }
}
variable "services_nodepool_disable_logging" {
  type    = bool
  default = false
}
variable "services_nodepool_disable_monitoring" {
  type    = bool
  default = false
}
variable "services_nodepool_disable_trace" {
  type    = bool
  default = false
}
variable "services_nodepool_timeouts_create" {
  type    = string
  default = "1h"
}
variable "services_nodepool_timeouts_update" {
  type    = string
  default = "3h"
}
variable "services_nodepool_timeouts_delete" {
  type    = string
  default = "1h"
}

# Non-persistent Redis (Memorystore)

variable "non_persistent_redis_name" {
  type    = string
  default = "non-persistent-redis"
}
variable "non_persistent_redis_tier" {
  type    = string
  default = "BASIC"

}
variable "non_persistent_redis_memory_size_gb" {
  type    = number
  default = 1
}

variable "non_persistent_redis_location_id" {
  type    = string
  default = "asia-northeast1-a"
}
variable "non_persistent_redis_alternative_location_id" {
  type    = string
  default = ""
}
variable "non_persistent_redis_version" {
  type    = string
  default = "REDIS_6_X"
}
variable "non_persistent_redis_configs" {
  type = map(string)
  default = {
    maxmemory-policy = "allkeys-lru"
    maxmemory-gb     = "0.8"
    activedefrag     = "yes"
  }
}

# Persistent Redis (Memorystore)

variable "persistent_redis_name" {
  type    = string
  default = "persistent-redis"
}
variable "persistent_redis_tier" {
  type    = string
  default = "BASIC"
}
variable "persistent_redis_memory_size_gb" {
  type    = number
  default = 1
}
variable "persistent_redis_location_id" {
  type    = string
  default = "asia-northeast1-a"
}
variable "persistent_redis_alternative_location_id" {
  type    = string
  default = ""
}
variable "persistent_redis_version" {
  type    = string
  default = "REDIS_6_X"
}
variable "persistent_redis_configs" {
  type = map(string)
  default = {
    maxmemory-policy = "noeviction"
    maxmemory-gb     = "0.8"
    activedefrag     = "yes"
  }
}

# BigQuery

variable "bigquery_evaluation_events_table_schema_file" {
  type    = string
  default = "./bigquery/evaluation-events-table.json"
}
variable "bigquery_goal_events_table_schema_file" {
  type    = string
  default = "./bigquery/goal-events-table.json"
}
variable "bigquery_dataset_id" {
  type    = string
  default = "bucketeer"
}
variable "bigquery_friendly_name" {
  type    = string
  default = "bucketeer"
}
variable "bigquery_description" {
  type    = string
  default = "Bucketeer dataset"
}
variable "bigquery_location" {
  type    = string
  default = "asia-northeast1"
}
variable "bigquery_labels" {
  type    = string
  default = "default"
}
variable "bigquery_table_time_partitioning_type" {
  type    = string
  default = "DAY"
}
variable "bigquery_table_time_partitioning_expiration_ms" {
  type    = number
  default = 2678400000 # 31 days
}
variable "bigquery_table_deletion_protection" {
  type = bool
  default = true
}

# Bucketeer MySQL (CloudSQL)

variable "bucketeer_mysql_name" {
  type    = string
  default = "bucketeer-mysql"
}
variable "bucketeer_mysql_region" {
  type    = string
  default = "asia-northeast1"
}
variable "bucketeer_mysql_version" {
  type    = string
  default = "MYSQL_8_0"
}
variable "bucketeer_mysql_tier" {
  type    = string
  default = "db-n1-standard-1"
}
variable "bucketeer_mysql_activation_policy" {
  type    = string
  default = "ALWAYS"
}
variable "bucketeer_mysql_availability_type" {
  type    = string
  default = "ZONAL"
}
variable "bucketeer_mysql_disk_autoresize" {
  type    = bool
  default = false
}
variable "bucketeer_mysql_disk_type" {
  type    = string
  default = "PD_SSD"
}
variable "bucketeer_mysql_deletion_protection" {
  type = bool
  default = true
}
variable "bucketeer_mysql_backup_configuration_start_time" {
  type    = string
  default = "20:00"
}
variable "bucketeer_mysql_maintenance_window_update_track" {
  type    = string
  default = "canary"
}
variable "bucketeer_mysql_location" {
  type    = string
  default = "asia-northeast1-a"
}
variable "bucketeer_mysql_user_name" {
  type    = string
  default = "dbadmin"
}
variable "bucketeer_mysql_user_password" {
  type = string
}

# DNS

variable "dns_managed_zone_name" {
  type = string
}
variable "dns_region" {
  type = string
}
variable "dns_name" {
  type = string
}
variable "dns_admin_console_name" {
  type = string
}
variable "dns_address" {
  type    = string
  default = ""
}
variable "dns_ttl" {
  type    = number
  default = 60
}
variable "dns_is_global" {
  type    = bool
  default = false
}

# DNS Private

variable "dns_private_managed_zone_name" {
  type    = string
  default = "bucketeer-private"
}

variable "dns_private_name" {
  type    = string
  default = "bucketeer.private"
}

# DNS L7 API

variable "dns_l7_api_name" {
  type = string
}

variable "dns_l7_api_address" {
  type    = string
  default = ""
}

variable "dns_l7_api_ttl" {
  type    = number
  default = 60
}

# DNS Private Redis (Memorystore)

variable "dns_private_non_persistent_redis_name" {
  type    = string
  default = "non-persistent-redis.bucketeer.private"
}
variable "dns_private_non_persistent_redis_ttl" {
  type    = number
  default = 60
}
variable "dns_private_persistent_redis_name" {
  type    = string
  default = "persistent-redis.bucketeer.private"
}
variable "dns_private_persistent_redis_ttl" {
  type    = number
  default = 60
}

# DNS Private Bucketeer MySQL (CloudSQL)

variable "dns_private_bucketeer_mysql_name" {
  type    = string
  default = "mysql.bucketeer.private"
}
variable "dns_private_bucketeer_mysql_ttl" {
  type    = number
  default = 60
}

# KMS

variable "bucketeer_key_ring_name" {
  type    = string
  default = "bucketeer"
}
variable "bucketeer_key_ring_location" {
  type    = string
  default = "asia-northeast1"
}
variable "webhook_key_name" {
  type    = string
  default = "webhook"
}
