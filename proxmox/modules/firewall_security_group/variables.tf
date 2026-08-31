variable "name" {
  type = string
}

variable "comment" {
  type = string
}

variable "rule" {
  type = list(object({

    type = string
    action = string
    comment = string
    dest = optional(string)
    dport = optional(string)
    log = optional(string, "info")
    enabled = optional(bool, true)
    macro = optional(string)
    source = optional(string)
  }))
}