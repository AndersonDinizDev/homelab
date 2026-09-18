terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_persistent_volume_claim_v1" "this" {

  metadata {
    name = var.metadata.name
  }

  spec {
    storage_class_name = "local-storage"

    resources {
      requests = {
        storage = var.spec.resources.requests.storage
      }
    }
    access_modes = var.spec.access_modes
    volume_name = var.spec.volume_name
  }
}
