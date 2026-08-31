terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_deployment_v1" "this" {


  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      name = metadata.value.name
      labels = {
        app = metadata.value.labels.app
      }
    }
  }

  dynamic "spec" {
    for_each = var.spec != null ? [var.spec] : []
    content {
      replicas = spec.value.replicas
      selector {
        match_labels = {
          app = spec.value.selector.matchLabels.app
        }
      }
      template {
        metadata {
          labels = {
            app = spec.value.template.metadata.labels.app
          }
        }
        spec {
          node_name = spec.value.template.spec.node_name
          container {
            name = spec.value.template.spec.containers.name
            image = spec.value.template.spec.containers.image
            port {
              container_port = spec.value.template.spec.containers.ports.containerPort
            }
          }
        }
      }
    }
  }
}