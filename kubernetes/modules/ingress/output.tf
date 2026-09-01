output "load_balancer_ips" {
  value = [
    for i in try(kubernetes_ingress_v1.this.status[0].load_balancer[0].ingress, []) : i.ip
  ]
}