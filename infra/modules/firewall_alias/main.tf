terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_firewall_alias" "this" {

  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id
  container_id = var.container_id
  comment   = var.comment
  cidr = var.cidr
}