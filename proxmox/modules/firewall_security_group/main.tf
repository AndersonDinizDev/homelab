terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "this" {
  name = var.name
  comment = var.comment

  dynamic "rule" {
    for_each = var.rule != null ? var.rule : []
    content {
      type = rule.value.type
      action = rule.value.action
      comment = rule.value.comment
      dest = rule.value.dest
      dport = rule.value.dport
      log = rule.value.log
      enabled = rule.value.enabled
      macro = rule.value.macro
      source = rule.value.source
    }
  }

}
