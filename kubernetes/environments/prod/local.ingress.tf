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
          },
          {
            host = "seerr.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "seerr-service"
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
    2 = {
      wait_for_load_balancer = false
      metadata = {
        name      = "work-center-ingress"
        namespace = "work-center"
      }

      spec = {
        ingressClassName = "traefik"
        rule = [
          {
            host = "vault.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "vaultwarden-service"
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
            host = "notes.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "triliumnotes-service"
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
            host = "n8n.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "n8n-service"
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
    3 = {
      wait_for_load_balancer = false
      metadata = {
        name      = "backend-center-ingress"
        namespace = "backend-center"
      }

      spec = {
        ingressClassName = "traefik"
        rule = [
          {
            host = "message.andersondiniz.com"
            http = {
              path = [
                {
                  path     = "/"
                  pathType = "Prefix"
                  backend = {
                    service = {
                      name = "gotify-service"
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