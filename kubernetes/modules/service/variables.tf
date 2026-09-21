variable "metadata" {
  type = object({
    name = string
    namespace = optional(string)
  })
}

variable "spec" {
  type = object({
    selector = object({
      app = string
    })
    ports = list(object({
      protocol = string
      port = number
      targetPort = number
      name  = optional(string)
    }))
  })
}
