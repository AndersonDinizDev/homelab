variable "metadata" {
  type = object({
    name = string
  })
}

variable "spec" {
  type = object({

    resources = object({
      requests = object({
        storage = string
      })
    })

    access_modes = list(string)
    volume_name = string
  })
}