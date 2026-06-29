variable "node_name" {
  type        = string
  default     = ""
  description = "Nome do nó do cluster"
}

variable "vm_id" {
  type        = number
  default     = 1
  description = "Id da LXC"
}

variable "description" {
  type        = string
  default     = ""
  description = "Descrição da LXC"
}

variable "unprivileged" {
  type        = bool
  default     = true
  description = "Configuração de privilégio"
}

variable "features" {
  default = {}

  type = object({
    nesting = optional(bool, true)
  })

  description = "Configuração de recursos"
}

variable "initialization" {
  description = "Configuração de inicialização"

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
  description = "Configuração de disco"

  default = {}

  type = object({
    size         = optional(number)
    datastore_id = optional(string, "local-lvm")
  })
}

variable "operating_system" {
  description = "Configuração do sistema operacional"

  type = object({
    template_file_id = string
    type             = optional(string, "debian")
  })
}

variable "memory" {
  description = "Configuração de memória ram"

  default = {}

  type = object({
    dedicated = optional(number)
    swap      = optional(number, 0)
  })
}

variable "tags" {
  description = "Tags da LXC"

  type    = list(string)
  default = []
}

variable "network_interface" {
  description = "Configuração de rede"

  type = object({
    name   = string
    bridge = optional(string, "vmbr0")
    firewall = optional(bool, false)
  })
}



