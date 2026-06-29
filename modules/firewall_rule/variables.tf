variable "node_name" {
  type = string
}

variable "vm_id" {
  type = string
}

variable "container_id" {
  type = string
}

variable "rule" {
  type = list(object({
    action = string
    type = string
    comment = optional(string)
    dest = optional(string)
    dport = optional(string)
    enabled = optional(bool)
    iface = optional(string)
    log = optional(string)
    macro = optional(string)
    proto = optional(string)
    source = optional(string)
    sport = optional(string)
  }))
}