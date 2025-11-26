terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock" 
  # BAD PRACTICE: direct access to Docker socket
}

# BAD PRACTICE: no image digest, latest used
resource "docker_image" "bad_image" {
  name = "python:latest"
}

# BAD PRACTICE: container with privileged mode enabled
resource "docker_container" "bad_container" {
  name  = "bad_practice_container"
  image = docker_image.bad_image.latest

  # BAD PRACTICE: mount host root filesystem
  volumes {
    host_path      = "/"
    container_path = "/host-root"
  }

  # BAD PRACTICE: environment with hardcoded secrets
  env = [
    "SECRET_TOKEN=123456",
    "ENV=development"
  ]

  # BAD PRACTICE: expose container to all networks publicly
  ports {
    internal = 80
    external = 80
  }

  # BAD PRACTICE: privileged container
  privileged = true
}