terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

module "nginx" {
  source = "./modules"
  container_name = "tutorial"
  image_name = "nginx"
}
