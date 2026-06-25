locals {
  container = {
    # lxc_101 = {
    #   node_name    = "pve2"
    #   vm_id        = 101
    #   unprivileged = true
    #   features = {
    #     nesting = true
    #   }
    #   initialization = {
    #     hostname = "pbs-1"
    #     ip_config = {
    #       ipv4 = {
    #         address = "192.168.100.32/24"
    #         gateway = "192.168.100.1"
    #       }
    #     }
    #     user_account = {
    #       password = var.user_password
    #     }
    #   }
    #   disk = {
    #     size         = 8
    #     datastore_id = "local-lvm"
    #   }
    #   operating_system = {
    #     template_file_id = "local:iso/proxmox-backup-server_4.2-1.iso"
    #     type             = "debian"
    #   }
    #   memory = {
    #     dedicated = 2048
    #     swap      = 2048
    #   }
    #   network_interface = {
    #     name   = "eth0"
    #     bridge = "vmbr0"
    #   }
    # }
  }
}
