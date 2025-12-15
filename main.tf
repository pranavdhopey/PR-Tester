provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

resource "google_compute_instance" "vm" {
  name         = "hello-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
