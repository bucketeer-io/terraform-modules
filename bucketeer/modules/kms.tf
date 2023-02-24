# resource "google_kms_key_ring" "bucketeer" {
#   depends_on = [google_project_service.services]
#   project    = var.gcp_project
#   name       = var.bucketeer_key_ring_name
#   location   = var.bucketeer_key_ring_location
# }

# resource "google_kms_crypto_key" "webhook" {
#   depends_on = [google_kms_key_ring.bucketeer]
#   name       = var.webhook_key_name
#   key_ring   = google_kms_key_ring.bucketeer.id
# }

# resource "google_kms_crypto_key_iam_member" "webhook-iam" {
#   depends_on    = [google_project_service.services]
#   crypto_key_id = google_kms_crypto_key.webhook.id
#   role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member        = "serviceAccount:${data.google_compute_default_service_account.default.email}"
# }
