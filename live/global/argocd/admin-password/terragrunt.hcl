terraform {
  source = "${get_repo_root()}/modules/k8s//data"
}

dependencies {
  paths = ["../helm"]
}

include "cluster_auth" {
  path   = "${get_repo_root()}/_envcommon/cluster-auth.hcl"
  expose = true
}

inputs = {
  # cluster_auth = dependency.cluster.outputs.auth
  resources = [{
    kind      = "Secret"
    namespace = "argocd"
    name      = "argocd-initial-admin-secret"
  }]
}

