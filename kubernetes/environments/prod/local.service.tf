locals {
  services = {
    1 = {
      metadata = {
        name = "teste-service-1"
      }
      spec = {
        selector = {
          app = "nginx"
        }
        ports = {
          protocol   = "TCP"
          port       = 8000
          targetPort = 80
        }
      }
    }
  }
}