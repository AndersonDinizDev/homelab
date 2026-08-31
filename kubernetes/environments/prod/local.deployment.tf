locals {
  deployments = {
    1 = {
      metadata = {
        name = "nginx-deployment"
        labels = {
          app = "nginx"
        }
      }
      spec = {
        replicas = 3
        selector = {
          matchLabels = {
            app = "nginx"
          }
        }
        template = {
          metadata = {
            labels = {
              app = "nginx"
            }
          }
          spec = {
            node_name = "k3s-worker-1"
            containers = {
              name  = "nginx"
              image = "nginx:latest"
              ports = {
                containerPort = 80
              }
            }
          }
        }
      }
    }
  }
}
