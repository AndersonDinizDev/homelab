locals {
  persistent_volume = {
    1 = {
      metadata = {
        name = "teste"
      }
      spec = {
        capacity = {
          storage = "100Gi"
        }
        persistent_volume_source = {
          nfs = {
            path   = "/storage-hd"
            server = "192.168.100.11"
          }
        }
        access_modes = ["ReadWriteMany"]
      }
    }
  }
}
