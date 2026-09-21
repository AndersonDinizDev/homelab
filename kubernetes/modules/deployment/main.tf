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
      namespace = var.metadata.namespace
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
          dynamic "container"  {

            for_each = var.spec.template.spec.containers != null ? var.spec.template.spec.containers : []
            content {
              name = container.value.name
              image = container.value.image
              dynamic "security_context" {
                for_each = container.value.securityContext != null ? [container.value.securityContext] : []

                content {
                  privileged = container.value.securityContext.privileged
                }
              }
              dynamic "resources" {
                for_each = container.value.resources != null ? [container.value.resources] : []

                content {
                  limits = {
                    cpu = resources.value.limits.cpu
                    memory = resources.value.limits.memory
                  }
                  requests = {
                    cpu = resources.value.requests.cpu
                    memory = resources.value.requests.memory
                  }
                }
              }
              dynamic "port"  {

                for_each = container.value.ports != null ? container.value.ports : []
                content {
                  container_port = port.value.containerPort
                  name = port.value.name
                  protocol = port.value.protocol
                }
              }
              dynamic "env" {

                for_each = container.value.env != null ? container.value.env : []
                content {
                  name = env.value.name
                  value = env.value.value
                }
              }
              dynamic "volume_mount" {
                for_each = container.value.volumeMounts != null ? container.value.volumeMounts : []
                content {
                  mount_path = volume_mount.value.mountPath
                  name = volume_mount.value.name
                  sub_path = volume_mount.value.subPath
                }
              }
            }
          }
          dynamic "volume" {
            for_each = var.spec.template.spec.volumes != null ? var.spec.template.spec.volumes : []
            content {
              name = volume.value.name

              dynamic "persistent_volume_claim" {
                for_each = volume.value.persistentVolumeClaim != null ? [volume.value.persistentVolumeClaim] : []
                content {
                  claim_name = persistent_volume_claim.value.claimName
                }
              }
              dynamic "host_path" {
                for_each = volume.value.host_path != null ? [volume.value.host_path] : []
                content {
                  path = host_path.value.path
                }
              }
            }
          }
        }
      }
  }
}