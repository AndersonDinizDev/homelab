locals {
  ingress = {
    1 = {
      wait_for_load_balancer = false
      metadata = {
        name      = "media-center-ingress"
        namespace = "media-center"
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
          },
          {
            host = "qbittorrent.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "qbittorrent-service"
                      port = {
                        name = "http"
                      }
                    }
                  }
                }
              ]
            }
          },
          {
            host = "radarr.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "radarr-service"
                      port = {
                        name = "http"
                      }
                    }
                  }
                }
              ]
            }
          },
          {
            host = "prowlarr.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "prowlarr-service"
                      port = {
                        name = "http"
                      }
                    }
                  }
                }
              ]
            }
          },
          {
            host = "sonarr.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "sonarr-service"
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