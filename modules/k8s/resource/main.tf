variable "cluster_auth" {
  type = object({
    host = string
    cert = string
    key  = string
    ca   = string
  })
}

variable "resources" {
  default = []
  type = list(any)
}

resource "kubernetes_namespace" "this" {
  for_each = { for v in var.resources : v.name => v if v.kind == "Namespace" } 
  metadata {
    name = lower(each.value.name)
    labels = try(each.value.labels, {})
    annotations = try(each.value.annannotations, {})
  }
}

output "resources" {
  value = {
    namespace = resource.kubernetes_namespace.this
  }
}