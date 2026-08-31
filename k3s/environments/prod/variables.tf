variable "host" {
  description = "Host do cluster k3s"
  sensitive   = true
  type        = string
}