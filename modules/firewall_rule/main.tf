terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_firewall_rules" "this" {

  node_name = var.node_name
  vm_id = var.vm_id
  container_id = var.container_id

  dynamic "rule" {
    for_each = var.rule != null ? var.rule : []
    content {
      action = rule.value.action
      type = rule.value.type
      comment = rule.value.comment
      dest = rule.value.dest
      dport = rule.value.dport
      enabled = rule.value.enabled
      iface = rule.value.iface
      log = rule.value.log
      macro = rule.value.macro
      proto = rule.value.proto
      source = rule.value.source
      sport = rule.value.sport
    }
  }
}
