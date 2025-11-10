terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# --- Variables ---

variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "The region for the Cloud Run service deployment."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name for the Cloud Run service."
  type        = string
  default     = "hello-cloud-run-tf"
}

variable "container_image" {
  description = "The container image URL to deploy."
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "min_instances" {
  description = "Minimum number of container instances to keep running."
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of container instances allowed."
  type        = number
  default     = 10
}
