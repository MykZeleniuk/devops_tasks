output "front_ip" {
  value = module.frontend.ip_front
}

output "back_ip" {
  value = module.backend.ip_back
}