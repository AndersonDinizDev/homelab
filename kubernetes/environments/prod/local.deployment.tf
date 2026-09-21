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
                    mountPath = "/data/downloads"
                    subPath   = "data/downloads"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/data/media"
                    subPath   = "data/media"
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
                    mountPath = "/data/downloads"
                    subPath   = "data/downloads"
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
    3 = {
      metadata = {
        name      = "radarr-deployment"
        namespace = "homelab"
        labels = {
          app = "radarr"
        }
      }
      spec = {
        replicas = 1
        selector = {
          matchLabels = {
            app = "radarr"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "radarr"
            }
          }
          spec = {
            containers = [
              {
                name  = "radarr"
                image = "lscr.io/linuxserver/radarr:latest"
                ports = [
                  {
                    containerPort = 7878
                    name = "http"
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
                  }
                ]
                volumeMounts = [
                  {
                    name      = "nt-storage"
                    mountPath = "/config"
                    subPath   = "rd-config"
                  },
                  {
                    name      = "nt-storage"
                    mountPath = "/data"
                    subPath   = "data"
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
