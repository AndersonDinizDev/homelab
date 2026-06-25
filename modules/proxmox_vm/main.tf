terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  node_name   = var.node_name
  description = var.description

  vm_id = var.vm_id

  tags = var.tags

  dynamic "agent" {
    for_each = var.agent != null ? [var.agent] : []
    content {
      enabled = agent.value.enabled
    }
  }

  stop_on_destroy = var.stop_on_destroy

  dynamic "cpu" {
    for_each = var.cpu != null ? [var.cpu] : []
    content {
      cores = cpu.value.cores
      type  = cpu.value.type
    }
  }

  dynamic "initialization" {
    for_each = var.initialization != null ? [var.initialization] : []
    content {

      dynamic "user_account" {
        for_each = initialization.value.user_account != null ? [initialization.value.user_account] : []

        content {
          password = user_account.value.password
        }
      }

      dynamic "ip_config" {
        for_each = initialization.value.ip_config != null ? [initialization.value.ip_config] : []
        content {

          dynamic "ipv4" {
            for_each = ip_config.value.ipv4 != null ? [ip_config.value.ipv4] : []

            content {
              address = ipv4.value.address
              gateway = ipv4.value.gateway
            }
          }
        }
      }
    }
  }

  dynamic "operating_system" {
    for_each = var.operating_system != null ? [var.operating_system] : []
    content {
      type = operating_system.value.type
    }
  }

  dynamic "disk" {
    for_each = [var.disk]
    content {
      size         = disk.value.size
      datastore_id = disk.value.datastore_id
      interface    = disk.value.interface
      file_id = disk.value.file_id
    }
  }


  dynamic "memory" {
    for_each = var.memory != null ? [var.memory] : []
    content {
      dedicated = memory.value.dedicated
    }
  }

  dynamic "network_device" {
    for_each = try(length(var.network_device), 0) > 0 ? [var.network_device] : []

    content {
      bridge = network_device.value.bridge
    }
  }

  dynamic "cdrom" {
    for_each = var.cdrom != null ? [var.cdrom] : []
    content {
      file_id = cdrom.value.file_id
    }
  }

}