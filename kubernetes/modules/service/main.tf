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
      namespace = var.metadata.namespace
    }

  spec  {
      selector = {
        app = var.spec.selector.app
      }
      dynamic "port" {
        for_each = var.spec.ports != null ? var.spec.ports : []
        content {
          protocol = port.value.protocol
          port = port.value.port
          target_port = port.value.targetPort
          name = port.value.name
        }
      }
    }
}