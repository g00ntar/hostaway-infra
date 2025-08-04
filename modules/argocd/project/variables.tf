variable "argocd_auth" {
  type = object({
    # host = string
    username = string
    password = string
  })
}

variable "cluster_auth" {
  type = object({
    host = string
    cert = string
    key  = string
    ca   = string
  })
}

variable "create" {
  default = true
}

variable "project" {
  default = {}
  type = map(any)
}