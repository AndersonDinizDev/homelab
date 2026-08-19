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
        checksum           = "0ce1f1d675733027d3e17a4665cb95e1d7173bdf67fb8a87ff822ff5ee025bc2a90ecb270465ef395755e41c868b40072eb9ac493810196d9cf68f941afb93dc"
        checksum_algorithm = "sha512"
        datastore_id       = "local"
      }
      ssh_key = var.ssh_key
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
        }
      }
      cpu = {
        cores = 1
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
        dedicated = 2048
        swap      = 0
      }
      network_interface = {
        bridge   = "vmbr0"
        firewall = true
      }
      img = {
        img_url            = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
        checksum           = "0ce1f1d675733027d3e17a4665cb95e1d7173bdf67fb8a87ff822ff5ee025bc2a90ecb270465ef395755e41c868b40072eb9ac493810196d9cf68f941afb93dc"
        checksum_algorithm = "sha512"
        datastore_id       = "local"
      }
      ssh_key = var.ssh_key
    }
  }
}