locals {
  group = {
    default = {
      name = "default-sg"
      comment = "Grupo de segurança padrão"
      rules = [
        {
          type    = "in"
          action  = "ACCEPT"
          comment = "Permitindo acesso SSH"
          source  = module.firewall_alias["my_notebook"].ip
          macro   = "SSH"
        }
      ]
    }
  }
}