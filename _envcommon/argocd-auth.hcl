dependency "admin_password" {
    config_path = "${get_repo_root()}/live/global/argocd/admin-password"
    mock_outputs = {
        secret_data = {
            argocd-initial-admin-secret = {
                data = {
                    password = "xxxxxxxxxxxxxxxx"
                }
            }
        }
    }

    mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
    argocd_auth = {
        username = "admin"
        password = dependency.admin_password.outputs.secret_data["argocd-initial-admin-secret"].data.password
    }
}