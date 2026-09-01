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
          source  = module.firewall_alias["my_notebook"].name
          macro   = "SSH"
          log     = "nolog"
        }
      ]
    },
    k3s-sg-master = {
      name    = "k3s-sg-master"
      comment = "Grupo de segurança k3s-master"
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["caddy_proxy"].name
          comment = "Permitindo comunicação entre o caddy e o master"
          macro   = "HTTP"
          log     = "nolog"
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = "+${module.firewall_ipset["workers_nodes"].name}"
          comment = "Permite comunicação entre worker e master"
          log     = "nolog"
        }
      ]
    }
    k3s-sg-worker = {
      name    = "k3s-sg-worker"
      comment = "Grupo de segurança k3s-worker"
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["caddy_proxy"].name
          comment = "Permitindo comunicação entre o caddy e os workers"
          macro   = "HTTP"
          log     = "nolog"
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["k3s_master"].name
          comment = "Permite comunicação entre worker e master"
          log     = "nolog"
        }
      ]
    }
  }
}