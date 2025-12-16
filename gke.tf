provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

resource "google_container_cluster" "gke" {
  name     = "mixed-cluster"
  location = "us-central1"

  initial_node_count = 1
}
