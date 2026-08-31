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

resource "kubernetes_namespace_v1" "teste" {
  metadata {
    name = "teste-namespace"
  }
}
