resource "helm_release" "this" {
  count = var.create ? 1 : 0

  # https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/Chart.yaml
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = var.chart
  version          = var.chart_version
  repository       = var.repository
  values           = var.values
  wait             = var.wait
}

output "release" {
  value = helm_release.this[0]
  sensitive = true
}

output "app_version" {
  value = helm_release.this[0].metadata[0].app_version
}