terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}
resource "proxmox_virtual_environment_container" "this" {
  node_name = var.node_name
  description = var.description

  vm_id = var.vm_id

  unprivileged = var.unprivileged


  dynamic "features" {
    for_each = [var.features]
    content {
      nesting = features.value.nesting
    }
  }

  dynamic "initialization" {
    for_each = [var.initialization]
    content {

      hostname = initialization.value.hostname

      dynamic "user_account" {
        for_each = try([initialization.value.user_account], [])

        content {
          password = user_account.value.password
        }
      }

      dynamic "ip_config" {
        for_each = try([initialization.value.ip_config], [])
        content {

          dynamic "ipv4" {
            for_each = try([ip_config.value.ipv4], [])

            content {
              address = ipv4.value.address
              gateway = ipv4.value.gateway
            }
          }
        }
      }
    }
  }

  dynamic "disk" {
    for_each = [var.disk]
    content {
      size = disk.value.size
      datastore_id = disk.value.datastore_id
    }
  }


  dynamic "operating_system" {
    for_each = [var.operating_system]
    content {
      template_file_id = operating_system.value.template_file_id
      type = operating_system.value.type
    }
  }

  dynamic "memory" {
    for_each = [var.memory]
    content {
      dedicated = memory.value.dedicated
      swap = memory.value.swap
    }
  }

  dynamic "network_interface" {
    for_each = [var.network_interface]

    content {
      name = network_interface.value.name
      bridge = network_interface.value.bridge
    }
  }

}