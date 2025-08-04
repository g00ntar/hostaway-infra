provider "argocd" {
#   server_addr = var.argocd_auth.host
  username    = var.argocd_auth.username
  password    = var.argocd_auth.password

  port_forward = true
  
  kubernetes {
    host = var.cluster_auth.host

    client_certificate     = var.cluster_auth.cert
    client_key             = var.cluster_auth.key
    cluster_ca_certificate = var.cluster_auth.ca
  }
}