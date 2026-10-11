variable "postgres_root_password" {
  sensitive = true
  type      = string
}

variable "dbhost" {
  type = string
}

variable "dbname" {
  type = string
}

variable "dbuser" {
  type = string
}

variable "dbpassword" {
  sensitive = true
  type      = string
}

variable "dbport" {
  type = string
}