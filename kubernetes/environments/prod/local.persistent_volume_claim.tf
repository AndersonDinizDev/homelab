locals {
  persistent_volume_claim = {
    1 = {
      metadata = {
        name      = "nt-storage"
        namespace = "homelab"
      }
      spec = {
        resources = {
          requests = {
            storage = "100Gi"
          }
        }
        access_modes = ["ReadWriteMany"]
        volume_name  = module.persistent_volume["1"].volume_name
      }
    }
  }
}
