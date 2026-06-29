locals {
  rule = {
    cluster = {
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          macro   = "SSH"
          source  = module.firewall_alias["my_notebook"].name
          dest    = "+${module.firewall_ipset["cluster_nodes"].name}"
          log     = "nolog"
          comment = "Permitindo acesso SSH"
          enabled = true
        },
        {
          type    = "in"
          action  = "ACCEPT"
          proto   = "tcp"
          source  = module.firewall_alias["caddy_proxy"].name
          dest    = "+${module.firewall_ipset["cluster_nodes"].name}"
          dport   = "8006"
          log     = "nolog"
          comment = "Permitindo proxy reverso"
          enabled = true
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = "+${module.firewall_ipset["cluster_nodes"].name}"
          dest    = "+${module.firewall_ipset["cluster_nodes"].name}"
          log     = "nolog"
          comment = "Permitindo comunicação entre os nós"
          enabled = true
        },
        {
          type    = "in"
          action  = "DROP"
          comment = "Bloqueando acessos fora das regras"
          log     = "info"
          enabled = true
        },
      ]
    },
    pve1_101 = {
      node_name    = "pve1"
      container_id = module.proxmox_lxc["101"].id
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          proto   = "tcp"
          source  = module.firewall_alias["caddy_proxy"].name
          dest    = module.firewall_alias["vaultwarden"].name
          dport   = "8000"
          log     = "nolog"
          comment = "Permitindo acesso a aplicação"
          enabled = true
        }
      ]
    }
  }
}
