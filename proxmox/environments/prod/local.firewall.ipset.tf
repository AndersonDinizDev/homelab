locals {
  ipset = {
    cluster_nodes = {
      name = "cluster_nodes"
      cidr = [
        {
          name    = module.firewall_alias["pve_1"].name
          comment = "Primeiro nó"
        },
        {
          name    = module.firewall_alias["pve_2"].name
          comment = "Segundo nó"
        }
      ]
    },
    workers_nodes = {
      name = "workers_nodes"
      cidr = [
        {
          name    = module.firewall_alias["k3s_worker_1"].name
          comment = "Primeiro worker"
        }
      ]
    }
  }
}