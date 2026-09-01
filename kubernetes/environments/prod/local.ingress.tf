locals {
  ingress = {
    1 = {
      wait_for_load_balancer = false
      metadata = {
        name = "teste-ingress"
      }
      spec = {
        ingressClassName = "traefik"
        rule = {
          host = "nginx.andersondiniz.com"
          http = {
            path = [
              {
                path     = "/"
                pathType = "Prefix"
                backend = {
                  service = {
                    name = "teste-service-1"
                    port = {
                      number = 8000
                    }
                  }
                }
              }
            ]
          }
        }
      }
    }
  }
}