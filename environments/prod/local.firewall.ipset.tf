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
    }
  }
}