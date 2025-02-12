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

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_file" "ca_key" {
  content = tls_private_key.key.private_key_pem
  filename = "${path.module}/certs/ca.key"
}

resource "tls_self_signed_cert" "ca_cert" {
  private_key_pem = tls_private_key.key.private_key_pem
  is_ca_certificate = true
  validity_period_hours = 43800
  allowed_uses = ["key_encipherment", "cert_signing", "crl_signing"]
  subject {
    country = "UA"
    province = "Test prov"
    locality = "Test local"
    common_name = "Test CA"
    organization = "Test Org"
    organizational_unit = "Test unit"
  }
}

resource "local_file" "ca_cert" {
  content = tls_self_signed_cert.ca_cert.cert_pem
  filename = "${path.module}/certs/ca.cert"
}

resource "tls_private_key" "key_internal" {
  algorithm = "RSA"
}


resource "local_file" "key_internal" {
  content = tls_private_key.key_internal.private_key_pem
  filename = "${path.module}/certs/internal_key.key"
}

resource "tls_cert_request" "internal_csr" {
  private_key_pem = tls_private_key.key_internal.private_key_pem
  dns_names = [ "localhost" ]

  subject {
    country = "UA"
    province = "Test prov internal"
    locality = "Test local internal"
    common_name = "Test CA internal"
    organization = "Test Org internal"
    organizational_unit = "Test unit internal"
  }
}

resource "tls_locally_signed_cert" "cert_internal" {
  cert_request_pem = tls_cert_request.internal_csr.cert_request_pem
  ca_private_key_pem = tls_private_key.key.private_key_pem
  ca_cert_pem = tls_self_signed_cert.ca_cert.cert_pem
  validity_period_hours = 43800
  allowed_uses = ["key_encipherment", "cert_signing", "crl_signing"]
}

resource "local_file" "inteernal_cert" {
  content = tls_locally_signed_cert.cert_internal.cert_pem
  filename = "${path.module}/certs/internal.cert"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"

  ports {
    internal = var.port_internal
    external = var.port_external
  }
}

output "ip_nginx" {
  value = docker_container.nginx.ip_address
}