locals {
  persistent_volume_claim = {
    1 = {
      metadata = {
        name      = "nt-storage"
        namespace = "media-center"
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
    2 = {
      metadata = {
        name      = "nt-storage-2"
        namespace = "work-center"
      }
      spec = {
        resources = {
          requests = {
            storage = "50Gi"
          }
        }
        access_modes = ["ReadWriteMany"]
        volume_name  = module.persistent_volume["2"].volume_name
      }
    }
  }
}
