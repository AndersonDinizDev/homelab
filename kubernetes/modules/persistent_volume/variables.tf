variable "metadata" {
  type = object({
    name = string
  })
}

variable "spec" {
  type = object({
    capacity = object({
      storage = string
    })
    persistent_volume_source = object({
      nfs = object({
        path = string
        server = string
      })
    })
    access_modes = list(string)
  })
}