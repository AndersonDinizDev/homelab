terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }

  backend "s3" {
    bucket = "homelab-259553642804-us-east-1-an"
    key    = "kubernetes/prod/terraform.tfstate"
    region = "us-east-1"

    encrypt      = true
    use_lockfile = true
  }
}
provider "kubernetes" {
  config_path = "./.kube/k3s-config.yaml"
}

module "deployment" {
  for_each = local.deployments

  source   = "../../modules/deployment"
  metadata = try(each.value.metadata, null)
  spec     = try(each.value.spec, null)
}

module "service" {
  for_each = local.services

  source   = "../../modules/service"
  metadata = try(each.value.metadata, null)
  spec     = try(each.value.spec, null)

  depends_on = [module.deployment]
}

module "ingress" {
  for_each = local.ingress

  source = "../../modules/ingress"


  wait_for_load_balancer = try(each.value.wait_for_load_balancer, false)
  metadata               = try(each.value.metadata, null)
  spec                   = try(each.value.spec, null)

  depends_on = [module.service]
}
