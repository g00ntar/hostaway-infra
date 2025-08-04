terraform {
  source = "${get_repo_root()}/modules/argocd//application"
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

dependency "project" {
  config_path = "../project"

  mock_outputs = {
    project = {
      id = "env-name"
    }
  }

  mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
    app_name     = "${dependency.project.outputs.project.id}-apps"
    project_name = dependency.project.outputs.project.id
    
    app_source = {
        url = "https://github.com/g00ntar/apps.git"
        path = keys(dependency.namespace.outputs.resources.namespace)[0]
        revision = "HEAD"
    }
    
    destination_namespace = keys(dependency.namespace.outputs.resources.namespace)[0]
}

