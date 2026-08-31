terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
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
