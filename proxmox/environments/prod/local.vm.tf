locals {
  vm = {
    102 = {
      name            = "k3s-master"
      node_name       = "pve1"
      vm_id           = 102
      tags            = ["debian", "terraform", "kubernetes"]
      stop_on_destroy = true
      agent = {
        enabled = true
      }
      initialization = {
        ip_config = {
          ipv4 = {
            address = "${module.firewall_alias["k3s_master"].ip}/24"
            gateway = module.firewall_alias["gateway"].ip
          }
        }
        user_account = {
          username = "k3s-master"
          password = var.user_password
          keys     = trimspace(data.local_file.ssh_public_key.content)
        }
      }
      cpu = {
        cores = 2
      }
      disk = {
        size         = 32
        datastore_id = "local-lvm"
        interface    = "scsi0"
      }
      operating_system = {
        type = "l26"
      }
      memory = {
        dedicated = 4096
        swap      = 0
      }
      network_interface = {
        bridge   = "vmbr0"
        firewall = true
      }
      img = {
        img_url            = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
        checksum           = "95e110dfcdbd0ed8a82a75ed9579802f9950cabf51a810dcc6388e81bc778188713878b9f28d583a0ea602fbf48b35996ae9ad37f584166d8fbd6489df248f53"
        checksum_algorithm = "sha512"
        datastore_id       = "local"
      }
    }
    103 = {
      name            = "k3s-worker-1"
      node_name       = "pve2"
      vm_id           = 103
      tags            = ["debian", "terraform", "kubernetes"]
      stop_on_destroy = true
      agent = {
        enabled = true
      }
      initialization = {
        ip_config = {
          ipv4 = {
            address = "${module.firewall_alias["k3s_worker_1"].ip}/24"
            gateway = module.firewall_alias["gateway"].ip
          }
        }
        user_account = {
          username = "k3s-worker-1"
          password = var.user_password
          keys     = trimspace(data.local_file.ssh_public_key.content)
        }
      }
      cpu = {
        cores = 2
      }
      disk = {
        size         = 32
        datastore_id = "local-lvm"
        interface    = "scsi0"
      }
      operating_system = {
        type = "l26"
      }
      memory = {
        dedicated = 4096
        swap      = 0
      }
      network_interface = {
        bridge   = "vmbr0"
        firewall = true
      }
      img = {
        img_url            = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
        checksum           = "95e110dfcdbd0ed8a82a75ed9579802f9950cabf51a810dcc6388e81bc778188713878b9f28d583a0ea602fbf48b35996ae9ad37f584166d8fbd6489df248f53"
        checksum_algorithm = "sha512"
        datastore_id       = "local"
      }
    }
  }
}