resource "google_project_iam_member" "host_service_agent_user" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  role       = "roles/container.hostServiceAgentUser"
  member     = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"

  lifecycle {
    ignore_changes = [member]
  }
}

resource "google_project_iam_member" "network_admin_user" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  role       = "roles/compute.networkAdmin"
  member     = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"

  lifecycle {
    ignore_changes = [member]
  }
}

resource "google_project_iam_member" "security_admin_user" {
  depends_on = [google_project_service.services]
  project    = var.gcp_project
  role       = "roles/compute.securityAdmin"
  member     = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"

  lifecycle {
    ignore_changes = [member]
  }
}

resource "google_project_iam_member" "service_storage_object_viewer_user" {
  depends_on = [google_project_service.services]
  project    = var.gcp_storage_project
  role       = "roles/storage.objectViewer"
  member     = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"

  lifecycle {
    ignore_changes = [member]
  }
}

# Subnet

resource "google_compute_subnetwork_iam_member" "subnetwork_gke_user" {
  project    = var.gcp_project
  subnetwork = var.network_subnetwork_name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
  provider   = google-beta
  depends_on = [google_compute_subnetwork.subnet]

  lifecycle {
    ignore_changes = [member]
  }
}

resource "google_compute_subnetwork_iam_member" "subnetwork_cloudservices_user" {
  project    = var.gcp_project
  subnetwork = var.network_subnetwork_name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com"
  provider   = google-beta
  depends_on = [google_compute_subnetwork.subnet]

  lifecycle {
    ignore_changes = [member]
  }
}

# Application service account
resource "google_service_account" "bucketeer_application_default" {
  depends_on   = [google_project_service.services]
  account_id   = "bucketeer-application-default"
  display_name = "Service Account for bucketeer application default"
}

resource "google_project_iam_member" "bucketeer_application_default_roles_binding" {
  depends_on = [google_service_account.bucketeer_application_default]
  for_each   = toset(local.bucketeer_application_default_roles)
  project    = var.gcp_project
  role       = each.value
  member     = "serviceAccount:${google_service_account.bucketeer_application_default.email}"
}

resource "google_service_account_iam_member" "bucketeer_application_default_sa_binding" {
  depends_on = [
    google_project_iam_member.bucketeer_application_default_roles_binding,
    google_container_cluster.cluster
  ]
  for_each           = toset(local.bucketeer_application_default_kubernetes_sa)
  service_account_id = google_service_account.bucketeer_application_default.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.gcp_project}.svc.id.goog[${each.value}]"
}

resource "google_service_account" "bucketeer_event_counter" {
  depends_on   = [google_project_service.services]
  account_id   = "bucketeer-event-counter"
  display_name = "Service Account for bucketeer-event-counter"
}

resource "google_project_iam_member" "bucketeer_event_counter_roles_binding" {
  depends_on = [google_service_account.bucketeer_event_counter]
  for_each   = toset(local.bucketeer_event_counter_roles)
  project    = var.gcp_project
  role       = each.value
  member     = "serviceAccount:${google_service_account.bucketeer_event_counter.email}"
}

resource "google_service_account_iam_member" "bucketeer_event_counter_sa_binding" {
  depends_on = [
    google_project_iam_member.bucketeer_event_counter_roles_binding,
    google_container_cluster.cluster
  ]
  for_each           = toset(local.bucketeer_event_counter_kubernetes_sa)
  service_account_id = google_service_account.bucketeer_event_counter.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.gcp_project}.svc.id.goog[${each.value}]"
}

resource "google_service_account" "bucketeer_event_persister_dwh" {
  depends_on   = [google_project_service.services]
  account_id   = "bucketeer-event-persister-dwh"
  display_name = "Service Account for bucketeer-event-persister-dwh"
}

resource "google_project_iam_member" "bucketeer_event_persister_dwh_roles_binding" {
  depends_on = [google_service_account.bucketeer_event_persister_dwh]
  for_each   = toset(local.bucketeer_event_persister_dwh_roles)
  project    = var.gcp_project
  role       = each.value
  member     = "serviceAccount:${google_service_account.bucketeer_event_persister_dwh.email}"
}

resource "google_service_account_iam_member" "bucketeer_event_persister_dwh_sa_binding" {
  depends_on = [
    google_project_iam_member.bucketeer_event_persister_dwh_roles_binding,
    google_container_cluster.cluster
  ]
  for_each           = toset(local.bucketeer_event_persister_dwh_kubernetes_sa)
  service_account_id = google_service_account.bucketeer_event_persister_dwh.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.gcp_project}.svc.id.goog[${each.value}]"
}

locals {
  # iam role
  bucketeer_application_default_roles = [
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "roles/cloudtrace.agent",
    "roles/pubsub.editor",
  ]
  bucketeer_event_counter_roles = [
    "roles/bigquery.dataViewer",
    "roles/bigquery.jobUser",
    "roles/cloudtrace.agent",
  ]
  bucketeer_event_persister_dwh_roles = [
    "roles/bigquery.dataEditor",
    "roles/cloudtrace.agent",
    "roles/pubsub.editor",
  ]
  # Kubernetes Service Account
  bucketeer_application_default_kubernetes_sa = [
    "default/account",
    "default/account-apikey-cacher",
    "default/api-gateway",
    "default/auditlog",
    "default/auditlog-persister",
    "default/auth",
    "default/auto-ops",
    "default/calculator",
    "default/default",
    "default/dex",
    "default/environment",
    "default/event-persister",
    "default/event-persister-ops",
    "default/experiment",
    "default/feature",
    "default/feature-recorder",
    "default/feature-segment-persister",
    "default/feature-tag-cacher",
    "default/metrics-event-persister",
    "default/migration-mysql",
    "default/notification",
    "default/notification-sender",
    "default/ops-event-batch",
    "default/push",
    "default/push-sender",
    "default/user",
    "default/user-persister",
    "default/web",
    "default/web-gateway",
  ]
  bucketeer_event_counter_kubernetes_sa = [
    "default/event-counter",
  ]
  bucketeer_event_persister_dwh_kubernetes_sa = [
    "default/event-persister-dwh",
  ]
}
