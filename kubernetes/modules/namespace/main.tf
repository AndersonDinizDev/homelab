terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_namespace_v1" "this" {

  metadata {
    name = var.metadata.name
  }
}
