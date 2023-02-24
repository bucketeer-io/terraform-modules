# Cluster
output "instance_group_urls" {
  value = length(google_container_cluster.cluster.node_pool) > 0 ? google_container_cluster.cluster.node_pool[0].instance_group_urls : []
}

output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "client_certificate" {
  value = google_container_cluster.cluster.master_auth.0.client_certificate
}

output "client_key" {
  value     = google_container_cluster.cluster.master_auth.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value = google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
}
