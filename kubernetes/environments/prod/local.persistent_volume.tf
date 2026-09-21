locals {
  persistent_volume = {
    1 = {
      metadata = {
        name = "nt-storage"
      }
      spec = {
        capacity = {
          storage = "500Gi"
        }
        persistent_volume_source = {
          nfs = {
            path   = "/storage-pve/proxmox"
            server = "192.168.100.11"
          }
        }
        access_modes = ["ReadWriteMany"]
      }
    }
  }
}
