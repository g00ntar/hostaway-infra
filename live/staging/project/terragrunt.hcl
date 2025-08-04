terraform {
  source = "${get_repo_root()}/modules/argocd//project"
}

include "cluster_auth" {
  path   = "${get_repo_root()}/_envcommon/cluster-auth.hcl"
  expose = true
}

include "argocd_auth" {
  path   = "${get_repo_root()}/_envcommon/argocd-auth.hcl"
  expose = true
}

dependency "namespace" {
  config_path = "../namespace"
  mock_outputs = {
    resources = {
      namespace = {
        "test-namespace" = {}
      }
    }
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
  project = {
    name = keys(dependency.namespace.outputs.resources.namespace)[0]
  }
}

