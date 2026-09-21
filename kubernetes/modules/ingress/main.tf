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
    namespace = var.metadata.namespace
  }

  spec {
    ingress_class_name = var.spec.ingressClassName

    dynamic "rule" {

      for_each = var.spec.rule != null ? var.spec.rule : []
      content {
        host = rule.value.host

        http {
          dynamic "path" {
            for_each = rule.value.http.path != null ? rule.value.http.path : []
            content {
              path      = path.value.path
              path_type = path.value.pathType
              backend {
                service {
                  name = path.value.backend.service.name
                  port {
                    number = path.value.backend.service.port.number
                    name = path.value.backend.service.port.name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}