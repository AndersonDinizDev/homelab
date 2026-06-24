variable "api_token" {
  type        = string
  sensitive   = true
  description = "Token de api do proxmox"
}

variable "endpoint" {
  type        = string
  description = "Endpoint de requisição"
}

variable "user_password" {
  type = string
  description = "Senha do usuário root"
}