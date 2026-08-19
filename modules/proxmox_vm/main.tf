terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

data "local_file" "ssh_public_key" {
  filename = var.ssh_key
}

resource "proxmox_virtual_environment_vm" "this" {
  node_name   = var.node_name
  description = var.description
  name = var.name

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
          username = var.name
          password = user_account.value.password
          keys = [trimspace(data.local_file.ssh_public_key.content)]
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
      import_from = proxmox_download_file.latest_cloud_img.id
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
      firewall = network_device.value.firewall
    }
  }

  depends_on = [proxmox_download_file.latest_cloud_img]

}

resource "proxmox_download_file" "latest_cloud_img" {

  content_type = "import"
  datastore_id = var.img.datastore_id
  node_name    = var.node_name
  url          = var.img.img_url
  checksum = var.img.checksum
  checksum_algorithm = var.img.checksum_algorithm
}
