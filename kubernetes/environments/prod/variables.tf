variable "postgres_root_password" {
  sensitive = true
  type      = string
}

variable "postgres_n8n_user" {
  type = string
}

variable "postgres_n8n_password" {
  type      = string
  sensitive = true
}