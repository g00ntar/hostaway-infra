provider "kubernetes" {
    host = var.cluster_auth.host

    client_certificate     = var.cluster_auth.cert
    client_key             = var.cluster_auth.key
    cluster_ca_certificate = var.cluster_auth.ca
}