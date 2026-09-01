terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_service_v1" "this" {

  metadata  {
      name = var.metadata.name
    }

  spec  {
      selector = {
        app = var.spec.selector.app
      }
      port {
        protocol = var.spec.ports.protocol
        port = var.spec.ports.port
        target_port = var.spec.ports.targetPort
      }
    }
}