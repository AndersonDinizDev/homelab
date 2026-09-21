
variable "metadata" {
  type = object({
    name = string
    namespace = optional(string)
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
        node_name = optional(string)
        containers = list(object({
          name = string
          image = string
          securityContext = optional(object({
            privileged = bool
          }))
          resources = optional(object({
            limits = object({
              cpu = string
              memory = string
            })
            requests = object({
              cpu = string
              memory = string
            })
          }))
          ports = list(object({
            containerPort: number
            name: optional(string)
            protocol: optional(string, "TCP")
          }))
          env = optional(list(object({
            name = string
            value = string
          })))
          volumeMounts = optional(list(object({
            name = string
            mountPath = string
            subPath = optional(string)
          })))
        }))
        volumes = optional(list(object({
          name = string
          persistentVolumeClaim = optional(object({
            claimName = string
          }))
          host_path = optional(object({
            path = string
          }))
        })))
      })
    })
  })
}