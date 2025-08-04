dependency "cluster" {
    config_path = "${get_repo_root()}/live/global/cluster"
    mock_outputs = {
        auth = {
            host = "https://127.0.0.1:32771"
            ca   = "-----BEGIN CERTIFICATE-----"
            cert = "-----BEGIN CERTIFICATE-----"
            key  = "-----BEGIN RSA PRIVATE KEY-----"
        }
    }

    mock_outputs_allowed_terraform_commands = ["plan"]
}

inputs = {
    cluster_auth = dependency.cluster.outputs.auth
}