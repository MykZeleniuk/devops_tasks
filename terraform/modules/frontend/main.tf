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

resource "docker_image" "frontend" {
  name = "mzeleniuk/frontend:latest"
}

resource "docker_container" "frontend" {
  image = docker_image.frontend.image_id
  name = "frontend"

  ports {
    internal = var.port_internal
    external = var.port_external
  }
}

output "ip_front" {
  value = docker_container.frontend.ip_address
}