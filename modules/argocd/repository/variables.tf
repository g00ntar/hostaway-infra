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

variable "repos" {
  type = list(
    object({
      url = string
      key = string
    }
  ))
}