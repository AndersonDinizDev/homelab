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
  for_each = local.containers

  source            = "../../modules/proxmox_lxc"
  node_name         = each.value.node_name
  description       = each.value.description
  vm_id             = each.value.vm_id
  unprivileged      = each.value.unprivileged
  disk              = each.value.disk
  features          = each.value.features
  initialization    = each.value.initialization
  memory            = each.value.memory
  operating_system  = each.value.operating_system
  network_interface = each.value.network_interface
}