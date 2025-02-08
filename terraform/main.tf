terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  
  required_version = ">=0.12"
}

provider "docker" {}

module "nginx" {
  source = "./modules"
  container_name = "tutorial"
  image_name = "nginx"
}
