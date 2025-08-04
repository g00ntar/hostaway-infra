terraform {
  source = "${get_repo_root()}/modules/k8s//resource"
}

include "cluster_auth" {
  path   = "${get_repo_root()}/_envcommon/cluster-auth.hcl"
  expose = true
}

inputs = {
  # cluster_auth = dependency.cluster.outputs.auth
  resources = [{
    api_version = "v1"
    kind        = "Namespace"
    name        = "production"
  }]
}

