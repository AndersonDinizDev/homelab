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
                    mountPath = "/config"
                    subPath   = "jf-config"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/downloads"
                    subPath   = "qb-downloads"
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
    2 = {
      metadata = {
        name      = "qbittorrent-deployment"
        namespace = "homelab"
        labels = {
          app = "qbittorrent"
        }
      }
      spec = {
        replicas = 1
        selector = {
          matchLabels = {
            app = "qbittorrent"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "qbittorrent"
            }
          }
          spec = {
            node_name = "k3s-worker-1"
            containers = [
              {
                name  = "qbittorrent"
                image = "lscr.io/linuxserver/qbittorrent:latest"
                ports = [
                  {
                    containerPort = 8080
                    name          = "http"
                  },
                  {
                    containerPort = 6881
                    name          = "torrenting-tcp"
                  },
                  {
                    containerPort = 6881
                    name          = "torrenting-udp"
                    protocol      = "UDP"
                  }
                ]
                env = [
                  {
                    name  = "PUID"
                    value = "1000"
                  },
                  {
                    name  = "PGID"
                    value = "1000"
                  },
                  {
                    name  = "TZ"
                    value = "America/Sao_Paulo"
                  },
                  {
                    name  = "TORRENTING_PORT"
                    value = "6881"
                  },
                  {
                    name  = "WEBUI_PORT"
                    value = "8080"
                  }
                ]
                volumeMounts = [
                  {
                    name      = "nt-storage"
                    mountPath = "/config"
                    subPath   = "qb-config"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/downloads"
                    subPath   = "qb-downloads"
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
