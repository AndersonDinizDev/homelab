terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}

resource "kubernetes_ingress_v1" "this" {
  wait_for_load_balancer = var.wait_for_load_balancer

  metadata {
    name = var.metadata.name
  }

  spec {
    ingress_class_name = var.spec.ingressClassName

    rule {
      host = var.spec.rule.host

      http {
        dynamic "path" {
          for_each = var.spec.rule.http.path != null ? var.spec.rule.http.path : []
          content {
            path      = path.value.path
            path_type = path.value.pathType
            backend {
              service {
                name = path.value.backend.service.name
                port {
                  number = path.value.backend.service.port.number
                }
              }
            }
          }
        }
      }
    }
  }
}