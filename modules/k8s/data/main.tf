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

data "kubernetes_secret" "this" {
  for_each = { for v in var.resources : v.name => v if v.kind == "Secret" }
  metadata {
    namespace = try(each.value.namespace, "default")
    name = each.value.name
  }
}

output "secret_data" {
  value = data.kubernetes_secret.this
  sensitive = true
}