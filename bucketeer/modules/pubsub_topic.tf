resource "google_pubsub_topic" "domain" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-domain-events"
}

resource "google_pubsub_topic" "evaluation" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-evaluation-events"
}

resource "google_pubsub_topic" "goal" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-goal-events"
}

resource "google_pubsub_topic" "experiment" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-experiment-events"
}

resource "google_pubsub_topic" "ops" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-ops-events"
}

resource "google_pubsub_topic" "user" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-user-events"
}

resource "google_pubsub_topic" "metrics" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-metrics-events"
}

resource "google_pubsub_topic" "bulk_segment_users_received" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  name       = "${var.name}-bulk-segment-users-received-events"
}
