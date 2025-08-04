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

variable "app_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "destination_namespace" {
  type = string
  default = "argocd"
}

variable "namespace" {
  type = string
  default = "argocd"
}

variable "app_source" {
  type = object({
    url = string
    path = string 
    revision = string
  })
}

variable "labels" {
  default = {}
}

variable "annotations" {
  default = {}
}

variable "cascade" {
  default = true
}

variable "sync_policy" {
  type = object({
    prune = bool
    self_heal = bool
    allow_empty = bool
  })

  default = {
    prune = true
    self_heal = true
    allow_empty = true
  }
}