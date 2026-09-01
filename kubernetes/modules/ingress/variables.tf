variable "wait_for_load_balancer" {
  type    = bool
  default = false
}

variable "metadata" {
  type = object({
    name = string
  })
}

variable "spec" {
  type = object({
    ingressClassName = optional(string)
    rule = object({
      host = optional(string)
      http = object({
        path = list(object({
          path     = string
          pathType = string
          backend = object({
            service = object({
              name = string
              port = object({
                number = number
              })
            })
          })
        }))
      })
    })
  })
}