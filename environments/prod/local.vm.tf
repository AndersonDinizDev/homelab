locals {
  vm = {
    # vm_101 = {
    #   node_name       = "pve2"
    #   vm_id           = 101
    #   tags            = ["backup, terraform"]
    #   stop_on_destroy = true
    #   agent = {
    #     enabled = false
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
    #   cpu = {
    #     cores = 2
    #   }
    #   disk = {
    #     size         = 10
    #     datastore_id = "local-lvm"
    #     interface    = "scsi0"
    #   }
    #   operating_system = {
    #     type = "l26"
    #   }
    #   memory = {
    #     dedicated = 2048
    #     swap      = 2048
    #   }
    #   network_interface = {
    #     bridge = "vmbr0"
    #   }
    #   cdrom = {
    #     file_id = "local:iso/proxmox-backup-server_4.2-1.iso"
    #   }
    # }
  }
}