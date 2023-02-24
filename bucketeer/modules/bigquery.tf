resource "google_bigquery_dataset" "bucketeer_dataset" {
  depends_on    = [google_project_service.services]
  dataset_id    = var.bigquery_dataset_id
  friendly_name = var.bigquery_friendly_name
  description   = var.bigquery_description
  location      = var.bigquery_location
  labels = {
    env = var.bigquery_labels
  }
  # delete_contents_on_destroy = true
}

resource "google_bigquery_table" "evaluation-event" {
  depends_on = [google_bigquery_dataset.bucketeer_dataset]
  dataset_id = google_bigquery_dataset.bucketeer_dataset.dataset_id
  table_id   = "evaluation_event"

  time_partitioning {
    type          = var.bigquery_table_time_partitioning_type
    expiration_ms = var.bigquery_table_time_partitioning_expiration_ms
    field         = "timestamp"
  }
  schema = file(var.bigquery_evaluation_events_table_schema_file)
  deletion_protection = var.bigquery_table_deletion_protection
}

resource "google_bigquery_table" "goal-event" {
  depends_on = [google_bigquery_dataset.bucketeer_dataset]
  dataset_id = google_bigquery_dataset.bucketeer_dataset.dataset_id
  table_id   = "goal_event"

  time_partitioning {
    type          = var.bigquery_table_time_partitioning_type
    expiration_ms = var.bigquery_table_time_partitioning_expiration_ms
    field         = "timestamp"
  }
  schema = file(var.bigquery_goal_events_table_schema_file)
  deletion_protection = var.bigquery_table_deletion_protection
}
