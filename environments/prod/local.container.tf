locals {
  container = {
    vaultwarden = {
      node_name    = "pve1"
      vm_id        = 101
      unprivileged = true
      features = {
        nesting = true
      }
      tags = ["terraform", "debian", "vaultwarden"]
      initialization = {
        hostname = "vaultwarden"
        ip_config = {
          ipv4 = {
            address = "${module.firewall_alias["vaultwarden"].ip}/24"
            gateway = module.firewall_alias["gateway"].ip
          }
        }
        user_account = {
          password = var.user_password
        }
      }
      disk = {
        size         = 8
        datastore_id = "local-lvm"
      }
      operating_system = {
        template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
        type             = "debian"
      }
      memory = {
        dedicated = 2048
        swap      = 2048
      }
      network_interface = {
        name     = "eth0"
        bridge   = "vmbr0"
        firewall = true
      }
    }
    k3s_master = {
      node_name    = "pve1"
      vm_id        = 102
      unprivileged = true
      features = {
        nesting = true
      }
      tags = ["terraform", "debian", "kubernetes"]
      initialization = {
        hostname = "k3s-master"
        ip_config = {
          ipv4 = {
            address = "${module.firewall_alias["k3s_master"].ip}/24"
            gateway = module.firewall_alias["gateway"].ip
          }
        }
        user_account = {
          password = var.user_password
        }
      }
      disk = {
        size         = 8
        datastore_id = "local-lvm"
      }
      operating_system = {
        template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
        type             = "debian"
      }
      memory = {
        dedicated = 4096
        swap      = 4096
      }
      network_interface = {
        name     = "eth0"
        bridge   = "vmbr0"
        firewall = true
      }
    }
    k3s_worker_1 = {
      node_name    = "pve2"
      vm_id        = 103
      unprivileged = true
      features = {
        nesting = true
      }
      tags = ["terraform", "debian", "kubernetes"]
      initialization = {
        hostname = "k3s-worker-1"
        ip_config = {
          ipv4 = {
            address = "${module.firewall_alias["k3s_worker_1"].ip}/24"
            gateway = module.firewall_alias["gateway"].ip
          }
        }
        user_account = {
          password = var.user_password
        }
      }
      disk = {
        size         = 8
        datastore_id = "local-lvm"
      }
      operating_system = {
        template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
        type             = "debian"
      }
      memory = {
        dedicated = 2048
        swap      = 2048
      }
      network_interface = {
        name     = "eth0"
        bridge   = "vmbr0"
        firewall = true
      }
    }
  }
}
