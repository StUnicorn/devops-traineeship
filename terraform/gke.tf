#Creation of a GKE cluster

resource "google_container_cluster" "primary" {
  name = "todolist-gke-cluster"
  location = "europe-north1"
  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_node" {
  name = "todolist-node-pool"
  location = "europe-north1"
  cluster = google_container_cluster.primary.name
  node_count = 1

  node_config {
      preemptible = true
      machine_type = "e2-small"
    }
}

resource "google_service_account" "gke_sa" {
  account_id = "gke-cluster-viewer"
  display_name = "GKE-r"
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.registry.id
  role = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.gke_sa.email}"
}