#!/usr/bin/env bash
set -o errexit

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: '$1' not found in PATH."
        exit 1
    fi
}

check_command terraform
check_command terragrunt
check_command minikube

# Make backup of existing kubeconfig
if [ -f ~/.kube/config ]; then
    echo Creating ~/.kube/config backup in ~/.kube/config.bak 
    mv ~/.kube/config ~/.kube/config.bak
    sleep 2
fi

terragrunt --non-interactive apply --all -auto-approve \
    --working-dir='live/' \
    --queue-include-dir='global/cluster'

# Move kubeconfig 
mv ~/.kube/config ~/.kube/minikube

terragrunt --non-interactive apply --all -auto-approve \
    --working-dir='live/'

echo To use minikube ingress add line bellow to your /etc/hosts
echo "$(minikube ip -p hostaway) hostaway.lan"
echo
echo ---
echo
echo "echo $(minikube ip -p hostaway) hostaway.lan | sudo tee /etc/hosts"
