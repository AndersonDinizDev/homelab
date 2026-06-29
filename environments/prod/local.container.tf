locals {
  container = {
    101 = {
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
  }
}
