locals {
  services = {
    1 = {
      metadata = {
        name      = "jellyfin-service"
        namespace = "media-center"
      }
      spec = {
        selector = {
          app = "jellyfin"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 8096
            targetPort = 8096
            name       = "http"
          }
        ]
      }
    }
    2 = {
      metadata = {
        name      = "qbittorrent-service"
        namespace = "media-center"
      }
      spec = {
        selector = {
          app = "qbittorrent"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 8080
            targetPort = 8080
            name       = "http"
          },
          {
            protocol   = "TCP"
            port       = 6881
            targetPort = 6881
            name       = "torrenting-tcp"
          },
          {
            protocol   = "UDP"
            port       = 6881
            targetPort = 6881
            name       = "torrenting-udp"
          }
        ]
      }
    }
    3 = {
      metadata = {
        name      = "radarr-service"
        namespace = "media-center"
      }
      spec = {
        selector = {
          app = "radarr"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 7878
            targetPort = 7878
            name       = "http"
          }
        ]
      }
    }
    4 = {
      metadata = {
        name      = "prowlarr-service"
        namespace = "media-center"
      }
      spec = {
        selector = {
          app = "prowlarr"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 9696
            targetPort = 9696
            name       = "http"
          }
        ]
      }
    }
    5 = {
      metadata = {
        name      = "sonarr-service"
        namespace = "media-center"
      }
      spec = {
        selector = {
          app = "sonarr"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 8989
            targetPort = 8989
            name       = "http"
          }
        ]
      }
    }
    6 = {
      metadata = {
        name      = "vaultwarden-service"
        namespace = "work-center"
      }
      spec = {
        selector = {
          app = "vaultwarden"
        }
        ports = [
          {
            protocol   = "TCP"
            port       = 8972
            targetPort = 80
            name       = "http"
          }
        ]
      }
    }
  }
}