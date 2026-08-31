terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "this" {

  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id
  container_id = var.container_id
  comment   = var.comment

  dynamic "cidr" {
    for_each = var.cidr != null ? var.cidr : []
    content {
      name    = cidr.value.name
      comment = cidr.value.comment
      nomatch = cidr.value.nomatch
    }
  }
}