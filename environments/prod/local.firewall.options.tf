locals {
  options = {
    pve1_101 = {
      node_name     = "pve1"
      container_id  = module.proxmox_lxc["vaultwarden"].id
      dhcp          = true
      ipfilter      = false
      macfilter     = true
      ndp           = true
      radv          = true
      enabled       = true
      input_policy  = "DROP"
      output_policy = "ACCEPT"
      log_level_in  = "info"
      log_level_out = "nolog"
    }
    pve1_102 = {
      node_name     = "pve1"
      container_id  = module.proxmox_vm["vm_102"].id
      dhcp          = true
      ipfilter      = false
      macfilter     = true
      ndp           = true
      radv          = true
      enabled       = true
      input_policy  = "DROP"
      output_policy = "ACCEPT"
      log_level_in  = "info"
      log_level_out = "nolog"
    }
    # pve2_101 = {
    #   node_name     = "pve1"
    #   container_id  = module.proxmox_lxc["k3s_worker_1"].id
    #   dhcp          = true
    #   ipfilter      = false
    #   macfilter     = true
    #   ndp           = true
    #   radv          = true
    #   enabled       = true
    #   input_policy  = "DROP"
    #   output_policy = "ACCEPT"
    #   log_level_in  = "info"
    #   log_level_out = "nolog"
    # }
  }
}