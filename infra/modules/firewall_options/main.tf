terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_firewall_options" "this" {
  node_name = var.node_name
  vm_id = var.vm_id
  container_id = var.container_id
  dhcp = var.dhcp
  enabled = var.enabled
  ipfilter = var.ipfilter
  macfilter = var.macfilter
  ndp = var.ndp
  input_policy = var.input_policy
  output_policy = var.output_policy
  log_level_in = var.log_level_in
  log_level_out = var.log_level_out
  radv = var.radv
}
