output "ingress_ips" {
  value = {
    for k, v in module.ingress : k => v.load_balancer_ips
  }
}