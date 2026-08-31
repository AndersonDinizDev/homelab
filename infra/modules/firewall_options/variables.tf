variable "node_name" {
  type = string
}

variable "vm_id" {
  type = string
}
variable "container_id" {
  type = string
}
variable "dhcp" {
  type = string
}
variable "enabled" {
  type = bool
  default = true
}
variable "ipfilter" {
  type = bool
  default = false
}

variable "macfilter" {
  type = bool
  default = true
}

variable "ndp" {
  type = bool
  default = true
}

variable "input_policy" {
  type = string
  default = "ACCEPT"
}

variable "output_policy" {
  type = string
  default = "ACCEPT"
}

variable "log_level_in" {
  type = string
}

variable "log_level_out" {
  type = string
}

variable "radv" {
  type = string
}