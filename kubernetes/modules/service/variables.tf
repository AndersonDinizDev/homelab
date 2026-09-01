variable "metadata" {
  type = object({
    name = string
  })
}

variable "spec" {
  type = object({
    selector = object({
      app = string
    })
    ports = object({
      protocol = string
      port = number
      targetPort = number
    })
  })
}
