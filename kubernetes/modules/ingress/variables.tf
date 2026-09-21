variable "wait_for_load_balancer" {
  type    = bool
  default = false
}

variable "metadata" {
  type = object({
    name = string
    namespace = optional(string)
  })
}

variable "spec" {
  type = object({
    ingressClassName = optional(string)
    rule = list(object({
      host = optional(string)
      http = object({
        path = list(object({
          path     = string
          pathType = string
          backend = object({
            service = object({
              name = string
              port = object({
                number = optional(number)
                name = optional(string)
              })
            })
          })
        }))
      })
    }))
  })
}