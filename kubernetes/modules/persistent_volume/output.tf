output "volume_name" {
  value = kubernetes_persistent_volume_v1.this.metadata[0].name
}
