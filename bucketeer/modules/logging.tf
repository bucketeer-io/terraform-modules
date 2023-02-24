resource "google_logging_project_exclusion" "envoy-info-exclusion" {
  depends_on  = [google_project_service.services]
  name        = "envoy-info-exclusion"
  description = "Exclude Envoy info logs"
  filter      = "resource.type=\"k8s_container\" resource.labels.cluster_name=\"${var.cluster_name}\" resource.labels.container_name=\"envoy\" severity<=INFO"
}

resource "google_logging_project_exclusion" "http-lb-info-exclusion" {
  depends_on  = [google_project_service.services]
  name        = "http-lb-info-exclusion"
  description = "Exclude HTTP Load Balancer info logs"
  filter      = "resource.type=\"http_load_balancer\" severity<=INFO"
}
