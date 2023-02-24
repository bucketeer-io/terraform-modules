locals {
  logging_scope    = "https://www.googleapis.com/auth/logging.write"
  monitoring_scope = "https://www.googleapis.com/auth/monitoring"
  trace_scope      = "https://www.googleapis.com/auth/trace.append"

  service_auth_scopes = [
    "https://www.googleapis.com/auth/compute",
  ]
}
