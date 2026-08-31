variable "name" {
  type = string
}
variable "node_name" {
  type = string
}

variable "vm_id" {
  type = string
}

variable "container_id" {
  type = string
}
variable "comment" {
  type = string
}

variable "cidr" {
  type = list(object({
    name    = string
    comment = optional(string)
    nomatch = optional(bool, false)
  }))
}
