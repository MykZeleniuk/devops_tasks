terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
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
