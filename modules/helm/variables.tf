variable "cluster_auth" {
    type = map(string)
}
variable "create" {
  default = true
}

variable "name" {}
variable "namespace" {}
variable "create_namespace" {
    default = true
}
variable "chart" {}
variable "chart_version" {}
variable "repository" {}
variable "values" {
    default = []
    type = list(string)
}
variable "wait" {
  default = true
}