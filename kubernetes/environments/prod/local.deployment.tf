locals {
  deployments = {
    1 = {
      metadata = {
        name      = "jellyfin-deployment"
        namespace = "homelab"
        labels = {
          app = "jellyfin"
        }
      }
      spec = {
        replicas = 1
        selector = {
          matchLabels = {
            app = "jellyfin"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "jellyfin"
            }
          }
          spec = {
            node_name = "k3s-worker-1"
            containers = [
              {
                name  = "jellyfin"
                image = "jellyfin/jellyfin:latest"
                ports = [
                  {
                    containerPort = 8096
                    name          = "http"
                  }
                ]
                volumeMounts = [
                  {
                    name      = "nt-storage"
                    mountPath = "/mnt/nt-storage"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/config"
                    subPath   = "jf-config"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/media"
                    subPath   = "jf-media"
                  }
                ]
              }
            ]
            volumes = [
              {
                name = "nt-storage"
                persistentVolumeClaim = {
                  claimName = "nt-storage"
                }
              }
            ]
          }
        }
      }
    }
  }
}
