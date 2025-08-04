resource "argocd_application" "this" {
  count = var.create ? 1 : 0

  metadata {
    name      = var.app_name
    namespace = var.namespace
    
    labels      = var.labels
    annotations = var.annotations
  }

  cascade = var.cascade

  spec {
    project = var.project_name

    source {
      repo_url        = var.app_source.url
      path            = var.app_source.path
      target_revision = var.app_source.revision
    }

    destination {
      name      = "in-cluster"
      namespace = var.destination_namespace
    }

    sync_policy {
      automated {
        prune       = var.sync_policy.prune
        self_heal   = var.sync_policy.self_heal
        allow_empty = var.sync_policy.allow_empty
      }
    }
  }
}

output "application" {
  value = argocd_application.this[0]
}