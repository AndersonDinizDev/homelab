
variable "name" {
  description = "Nome da VM"

  type    = string
}

variable "node_name" {
  description = "Nome do nó do cluster"

  type    = string
  default = ""
}

variable "vm_id" {
  description = "Id da VM"

  type    = number
  default = 1
}

variable "description" {
  description = "Descrição da VM"

  type    = string
  default = ""
}

variable "tags" {
  description = "Tags da VM"

  type    = list(string)
  default = []
}

variable "agent" {
  description = "Configuração do agente QEMU"

  type = object({
    enabled = bool
  })
}

variable "stop_on_destroy" {
  description = "Parar a VM ao destruir"

  type    = bool
  default = true
}

variable "cpu" {
  description = "Configuração de CPU"

  type = object({
    cores = optional(number, 2)
    type  = optional(string, "x86-64-v2-AES")
  })
}

variable "initialization" {

  description = "Configuração de inicialização"

  default = {}

  type = object({

    user_account = optional(object({
      username = string
      password = string
      keys = string
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

  type = object({
    size         = optional(number, 8)
    datastore_id = optional(string, "local-lvm")
    interface    = string
    file_id = optional(string)
    import_from = optional(string)
  })
}

variable "operating_system" {
  type = object({
    type = optional(string, "l26")
  })
}


variable "memory" {
  description = "Configuração de memória ram"

  default = {}

  type = object({
    dedicated = optional(number, 1024)
    floating  = optional(number, 0)
  })
}

variable "network_device" {
  description = "Configuração de rede"

  type = object({
    bridge = optional(string, "vmbr0")
    firewall = optional(bool, false)
  })
}

variable "img" {
  description = "Configuração de imagem"

  type = object({
    img_url = string
    checksum = string
    checksum_algorithm = string
    datastore_id = string
  })
}



