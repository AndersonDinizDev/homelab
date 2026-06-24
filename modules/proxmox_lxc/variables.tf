variable "node_name" {
  type = string
  default = ""
}

variable "vm_id" {
  type = number
  default = 1
}

variable "description" {
  type = string
  default = ""
}

variable "unprivileged" {
  type = bool
  default = true
}

variable "features" {
  type = any
  default = {}
}

variable "initialization" {
  type = any
  default = {}
}

variable "disk" {
  type = any
  default = {}
}

variable "operating_system" {
  type = any
  default = {}
}

variable "memory" {
  type = any
  default = {}
}



