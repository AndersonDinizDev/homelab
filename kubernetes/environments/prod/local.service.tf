locals {
  services = {
    1 = {
      metadata = {
        name      = "jellyfin-service"
        namespace = "homelab"
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
  }
}