locals {
  ingress = {
    1 = {
      wait_for_load_balancer = false
      metadata = {
        name      = "jellyfin-ingress"
        namespace = "homelab"
      }
      spec = {
        ingressClassName = "traefik"
        rule = [
          {
            host = "streaming.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "jellyfin-service"
                      port = {
                        name = "http"
                      }
                    }
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}