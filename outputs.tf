output "cloud_run_service_url" {
  description = "The public URL for the deployed Cloud Run service."
  value       = google_cloud_run_v2_service.web_service.uri
}
