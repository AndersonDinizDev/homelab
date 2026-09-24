locals {
  deployments = {
    1 = {
      metadata = {
        name      = "jellyfin-deployment"
        namespace = "media-center"
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
            node_name = "k3s-master"
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
                resources = {
                  limits = {
                    cpu    = "2"
                    memory = "2Gi"
                  }
                  requests = {
                    cpu    = "250m"
                    memory = "512Mi"
                  }
                }
                volumeMounts = [
                  {
                    name      = "nt-storage"
                    mountPath = "/config"
                    subPath   = "jf-config"
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
    2 = {
      metadata = {
        name      = "qbittorrent-deployment"
        namespace = "media-center"
        labels = {
          app = "qbittorrent"
        }
      }
      spec = {
        replicas = 1
        strategy = {
          type = "Recreate"
        }
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
            hostNetwork = true
            dnsPolicy   = "ClusterFirstWithHostNet"
            node_name = "k3s-worker-1"
            containers = [
              {
                name  = "qbittorrent"
                image = "lscr.io/linuxserver/qbittorrent:latest"
                resources = {
                  limits = {
                    cpu    = "1"
                    memory = "1Gi"
                  }
                  requests = {
                    cpu    = "250m"
                    memory = "256Mi"
                  }
                }
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
    3 = {
      metadata = {
        name      = "radarr-deployment"
        namespace = "media-center"
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
                resources = {
                  limits = {
                    cpu    = "0.5"
                    memory = "1Gi"
                  }
                  requests = {
                    cpu    = "250m"
                    memory = "256Mi"
                  }
                }
                ports = [
                  {
                    containerPort = 7878
                    name          = "http"
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
    4 = {
      metadata = {
        name      = "prowlarr-deployment"
        namespace = "media-center"
        labels = {
          app = "prowlarr"
        }
      }
      spec = {
        replicas = 1
        selector = {
          matchLabels = {
            app = "prowlarr"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "prowlarr"
            }
          }
          spec = {
            containers = [
              {
                name  = "prowlarr"
                image = "lscr.io/linuxserver/prowlarr:latest"
                resources = {
                  limits = {
                    cpu    = "0.5"
                    memory = "1Gi"
                  }
                  requests = {
                    cpu    = "250m"
                    memory = "256Mi"
                  }
                }
                ports = [
                  {
                    containerPort = 9696
                    name          = "http"
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
                    subPath   = "pl-config"
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
    5 = {
      metadata = {
        name      = "sonarr-deployment"
        namespace = "media-center"
        labels = {
          app = "sonarr"
        }
      }
      spec = {
        replicas = 1
        selector = {
          matchLabels = {
            app = "sonarr"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "sonarr"
            }
          }
          spec = {
            containers = [
              {
                name  = "sonarr"
                image = "lscr.io/linuxserver/sonarr:latest"
                resources = {
                  limits = {
                    cpu    = "0.5"
                    memory = "1Gi"
                  }
                  requests = {
                    cpu    = "250m"
                    memory = "256Mi"
                  }
                }
                ports = [
                  {
                    containerPort = 8989
                    name          = "http"
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
                    subPath   = "sn-config"
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
