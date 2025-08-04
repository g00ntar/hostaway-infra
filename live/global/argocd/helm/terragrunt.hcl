terraform {
  source = "${get_repo_root()}/modules/helm"
}

include "cluster_auth" {
  path   = "${get_repo_root()}/_envcommon/cluster-auth.hcl"
  expose = true
}

inputs = {
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  chart_version = "8.2.5"
  name = "argocd"
  namespace = "argocd"
  wait = true
  values = [yamlencode({
    configs = {
      params = {
        "application.namespaces" = "staging,production"
      }
    }
  })]
}

