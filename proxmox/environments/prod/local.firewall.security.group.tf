locals {
  group = {
    default = {
      name    = "default-sg"
      comment = "Grupo de segurança padrão"
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          comment = "Permitindo acesso SSH"
          source  = module.firewall_alias["my_notebook"].ip
          macro   = "SSH"
          log     = "nolog"
        }
      ]
    },
    k3s = {
      name    = "k3s-sg"
      comment = "Grupo de segurança k3s"
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["caddy_proxy"].name
          comment = "Permitindo acesso ao cluster"
          macro   = "HTTP"
          log     = "nolog"
        }
      ]
    }
  }
}