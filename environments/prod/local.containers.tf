locals {
  containers = {
    lxc_102 = {
      node_name    = "pve1"
      vm_id        = 102
      description  = "teste"
      unprivileged = true
      features = {
        nesting = true
      }
      initialization = {
        hostname = "teste-container"
        ip_config = {
          ipv4 = {
            address = "192.168.100.13/24"
            gateway = "192.168.100.1"
          }
        }
        user_account = {
          password = var.user_password
        }
      }
      disk = {
        size         = 6
        datastore_id = "local-lvm"
      }
      operating_system = {
        template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
        type = "debian"
      }
      memory = {
        dedicated = 1024
        swap      = 1024
      }
      network_interface = {
        name   = "eth0"
        bridge = "vmbr0"
      }
    }
  }
}
