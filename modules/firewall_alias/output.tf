output "name" {
  value = proxmox_virtual_environment_firewall_alias.this.name
}

output "ip" {
  value = proxmox_virtual_environment_firewall_alias.this.cidr
}
