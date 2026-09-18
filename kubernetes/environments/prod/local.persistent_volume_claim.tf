locals {
  persistent_volume_claim = {
    1 = {
      metadata = {
        name = "teste"
      }
      spec = {
        resources = {
          requests = {
            storage = "5Gi"
          }
        }
        access_modes = ["ReadWriteMany"]
        volume_name  = module.persistent_volume["1"].volume_name
      }
    }
  }
}
