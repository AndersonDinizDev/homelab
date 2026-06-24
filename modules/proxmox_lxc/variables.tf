variable "node_name" {
  type = string
  default = ""
  description = "Nome do nó do cluster"
}

variable "vm_id" {
  type = number
  default = 1
  description = "Id da LXC"
}

variable "description" {
  type = string
  default = ""
  description = "Descrição da LXC"
}

variable "unprivileged" {
  type = bool
  default = true
  description = "Configuração de privilégio"
}

variable "features" {
  type = any
  default = {}
}

variable "initialization" {
  description = "Configurações de inicialização"

  default = {}

  type = object({
    hostname = optional(string, "container")

    user_account = optional(object({
      password = string
    }))

    ip_config = optional(object({

      ipv4 = optional(object({
        address = string
        gateway = string
      }))
    }))
  })
}

variable "disk" {
  description = "Configurações de disco"

  default = {}

  type = object({
    size = optional(number)
    datastore_id = optional(string, "local-lvm")
  })
}

variable "operating_system" {
description = "Configurações do sistema operacional"

  type = object({
    template_file_id = string
    type = optional(string, "debian")
  })
}

variable "memory" {
  description = "Configurações de memória ram"

  default = {}

  type = object({
    dedicated = optional(number)
    swap      = optional(number, 0)
  })
}

variable "network_interface" {
description = "Configurações de rede"

  type = object({
    name = string
    bridge      = optional(string, "vmbr0")
  })
}



