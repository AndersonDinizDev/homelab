terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.0"
    }
  }

  backend "s3" {
    bucket = "homelab-259553642804-us-east-1-an"
    key    = "infra/prod/terraform.tfstate"
    region = "us-east-1"

    encrypt      = true
    use_lockfile = true
  }
}

provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.api_token
}

module "proxmox_lxc" {
  for_each = local.container

  source            = "../../modules/proxmox_lxc"
  node_name         = each.value.node_name
  description       = try(each.value.description, null)
  vm_id             = each.value.vm_id
  unprivileged      = each.value.unprivileged
  disk              = each.value.disk
  features          = try(each.value.features, null)
  initialization    = try(each.value.initialization, {})
  memory            = try(each.value.memory, null)
  operating_system  = each.value.operating_system
  network_interface = try(each.value.network_interface, null)
}

module "proxmox_vm" {
  for_each = local.vm
  source   = "../../modules/proxmox_vm"

  node_name        = each.value.node_name
  description      = try(each.value.description, null)
  vm_id            = each.value.vm_id
  tags             = try(each.value.tags, null)
  agent            = try(each.value.agent, null)
  stop_on_destroy  = each.value.stop_on_destroy
  cpu              = try(each.value.cpu, null)
  initialization   = try(each.value.initialization, {})
  memory           = try(each.value.memory, null)
  operating_system = each.value.operating_system
  network_device   = try(each.value.network_interface, null)
  disk             = each.value.disk
  cdrom            = try(each.value.cdrom, null)
}

module "firewall_alias" {

  for_each = local.alias

  source = "../../modules/firewall_alias"

  name         = each.value.name
  node_name    = try(each.value.node_name, null)
  vm_id        = try(each.value.vm_id, null)
  container_id = try(each.value.container_id, null)
  comment      = try(each.value.container_id, null)
  cidr         = each.value.cidr
}

module "firewall_ipset" {

  for_each = local.ipset

  source = "../../modules/firewall_ipset"

  name         = each.value.name
  node_name    = try(each.value.node_name, null)
  vm_id        = try(each.value.vm_id, null)
  container_id = try(each.value.container_id, null)
  comment      = try(each.value.container_id, null)
  cidr         = each.value.cidr

  depends_on = [module.firewall_alias]
}