locals {
  alias = {
    gateway = {
      name = "gateway"
      cidr = "192.168.100.1"
    }
    pve_1 = {
      name = "pve_1"
      cidr = "192.168.100.11"
    }
    pve_2 = {
      name = "pve_2"
      cidr = "192.168.100.31"
    }
    my_notebook = {
      name = "my_notebook"
      cidr = "192.168.100.101"
    }
    my_phone = {
      name = "my_phone"
      cidr = "192.168.100.102"
    }
    caddy_proxy = {
      name = "caddy_proxy"
      cidr = "192.168.100.1"
    }
    vaultwarden = {
      name = "vaultwarden"
      cidr = "192.168.100.12"
    }
  }
}
