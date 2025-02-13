variable "image_name" {
  type = string
  description = "nginx"
}

variable "container_name" {
  type = string
  description = "tutorial"
}

variable "port_internal" {
  type = number
  description = "internal port"
  default = 80
}

variable "port_external" {
  type = number
  description = "external port"
  default = 8000
}