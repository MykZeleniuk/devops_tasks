terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "backend" {
  name = "mzeleniuk/backend:latest"
}

resource "docker_container" "backend" {
  image = docker_image.backend.image_id
  name = "backend"

  ports {
    internal = var.port_internal
    external = var.port_external
  }
}

output "ip_back" {
  value = docker_container.backend.ip_address
}