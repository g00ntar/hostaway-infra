provider "minikube" {
  kubernetes_version = "v1.30.0"
}

resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = "hostaway"
  addons = [
    "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]
}

output auth {
  value       = {
    host = minikube_cluster.docker.host
    cert = minikube_cluster.docker.client_certificate
    key  = minikube_cluster.docker.client_key
    ca   = minikube_cluster.docker.cluster_ca_certificate
  }
  sensitive   = true
  description = "Cluster auth data"
}


# provider "kubernetes" {
#   host = minikube_cluster.docker.host

#   client_certificate     = minikube_cluster.docker.client_certificate
#   client_key             = minikube_cluster.docker.client_key
#   cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
# }

# module 

# enable_argocd = true