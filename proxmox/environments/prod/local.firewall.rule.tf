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
          security_group = module.firewall_security_group["default"].id
          iface          = "net0"
          comment        = "Grupo de segurança padrão"
        },
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
    },
    pve1_102 = {
      node_name    = "pve1"
      container_id = module.proxmox_vm["102"].id
      rules = [
        {
          security_group = module.firewall_security_group["default"].id
          iface          = "net0"
          comment        = "Grupo de segurança padrão"
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["k3s_worker_1"].name
          dest    = module.firewall_alias["k3s_master"].name
          log     = "nolog"
          comment = "Permitindo comunicação entre VM's"
          enabled = true
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["my_notebook"].name
          dest    = module.firewall_alias["k3s_master"].name
          proto   = "tcp"
          dport   = "6443"
          log     = "nolog"
          comment = "Permitindo comunicação com o cluster k3s"
          enabled = true
        }
      ]
    },
    pve1_103 = {
      node_name    = "pve2"
      container_id = module.proxmox_vm["103"].id
      rules = [
        {
          security_group = module.firewall_security_group["default"].id
          iface          = "net0"
          comment        = "Grupo de segurança padrão"
        },
        {
          type    = "in"
          action  = "ACCEPT"
          source  = module.firewall_alias["k3s_master"].name
          dest    = module.firewall_alias["k3s_worker_1"].name
          log     = "nolog"
          comment = "Permitindo comunicação entre VM's"
          enabled = true
        }
      ]
    }
  }
}
