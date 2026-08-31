
variable "metadata" {
  type = object({
    name = string
    labels = object({
      app = string
    })
  })
}

variable "spec" {
  type = object({
    replicas = number
    selector = object({
      matchLabels = object({
        app = string
      })
    })
    template = object({
      metadata = object({
        labels = object({
          app = string
        })
      })
      spec = object({
        node_name = string
        containers = object({
          name = string
          image = string
          ports = object({
            containerPort: number
          })
        })
      })
    })
  })
}