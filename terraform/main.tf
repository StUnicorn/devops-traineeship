provider "google" {
  project = "k8s-test-project-339307"
  region = "europe-north1"
  zone = "europe-north1-a"
}

resource "google_container_registry" "registry" {
  project  = "k8s-test-project-339307"
  location = "EU"
}



resource "google_service_account" "service_account" {
  account_id   = "docker-registry-rw"
  display_name = "DCR-rw"
}

resource "google_storage_bucket_iam_member" "admin" {
  bucket = google_container_registry.registry.id
  role = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
