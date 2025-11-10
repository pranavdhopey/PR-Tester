# Define the Google Cloud Run Service (V2 API)
resource "google_cloud_run_v2_service" "web_service" {
  name     = var.service_name
  location = var.region
  project  = var.project_id
  
  # Allow traffic from all sources (public)
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    # Instance metadata
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    # Container specification
    containers {
      image = var.container_image # e.g., "us-docker.pkg.dev/cloudrun/container/hello"
      
      # Resources requested by the container
      resources {
        cpu    = "1" # 1 CPU core
        memory = "512Mi"
      }
      
      # Define environment variables
      env {
        name  = "SERVICE_PORT"
        value = "8080"
      }
    }
  }
}

# --- IAM Policy for Public Access ---
# 
# Cloud Run services require an IAM policy to allow users to invoke them. 
# This data block creates a policy that grants the "roles/run.invoker" role
# to "allUsers," effectively making the service publicly available.
data "google_iam_policy" "noauth_policy" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

# Apply the IAM policy to the Cloud Run service
resource "google_cloud_run_v2_service_iam_policy" "public_access" {
  location    = google_cloud_run_v2_service.web_service.location
  name        = google_cloud_run_v2_service.web_service.name
  project     = var.project_id
  policy_data = data.google_iam_policy.noauth_policy.policy_data
}
