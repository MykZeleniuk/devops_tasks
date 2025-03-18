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

provider "docker" {}

module "frontend" {
  source = "./modules/frontend"
}

module "backend" {
  source = "./modules/backend"
}

module "nginx" {
  source = "./modules/nginx"
}
