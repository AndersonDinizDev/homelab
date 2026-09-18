terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_persistent_volume_v1" "this" {

  metadata {
    name = var.metadata.name
  }

  spec {
    storage_class_name = "local-storage"
    capacity = {
      storage = var.spec.capacity.storage
    }

    persistent_volume_source {
      nfs {
        path   = var.spec.persistent_volume_source.nfs.path
        server = var.spec.persistent_volume_source.nfs.server
      }
    }
    access_modes = var.spec.access_modes
  }
}
