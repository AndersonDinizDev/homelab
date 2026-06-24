variable "api_token" {
  type        = string
  sensitive   = true
  description = "token proxmox"
}

variable "endpoint" {
  type        = string
  description = "endpoint proxmox"
}