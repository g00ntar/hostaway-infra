resource "argocd_project" "this" {
  count = var.create ? 1 : 0
  metadata {
    name      = var.project.name
    namespace = "argocd"
    labels = try(var.project.labels, {})
    annotations = try(var.project.annannotations, {})
  }

  spec {
    source_namespaces = ["*"]
    source_repos      = ["*"]

    signature_keys = []

    destination {
      name      = "in-cluster"
      namespace = "*"
    }
  }
}

output "project" {
  value = argocd_project.this[0]
}