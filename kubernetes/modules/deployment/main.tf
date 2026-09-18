terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}
resource "kubernetes_deployment_v1" "this" {

  metadata  {
      name = var.metadata.name
      labels = {
        app = var.metadata.labels.app
      }
  }

  spec  {
      replicas = var.spec.replicas
      selector  {
        match_labels = {
          app = var.spec.selector.matchLabels.app
        }
      }
      template  {
        metadata  {
          labels = {
            app = var.spec.template.metadata.labels.app
          }
        }
        spec  {
          node_name = var.spec.template.spec.node_name
          container  {
            name = var.spec.template.spec.containers.name
            image = var.spec.template.spec.containers.image
            port  {
              container_port = var.spec.template.spec.containers.ports.containerPort
            }
            volume_mount {
              mount_path = var.spec.template.spec.containers.volumeMounts.mountPath
              name       = var.spec.template.spec.containers.volumeMounts.name
            }
          }
          volume {
            name = var.spec.template.spec.volumes.name
            persistent_volume_claim {
              claim_name = var.spec.template.spec.volumes.persistentVolumeClaim.claimName
            }
          }
        }
      }
  }
}