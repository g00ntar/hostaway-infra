# Minikube infrastructure repository

## Setup
1. Ensure that minikube, terraform and terragrunt binaries are accessible in you path - to install two last you can use [tenv](https://github.com/tofuutils/tenv)
2. Clone repo - `git clone https://github.com/g00ntar/hostaway-infra.git`
3. run `./bootstrap.sh`
4. If you want to use ingress add minikube ip to your `/etc/hosts` file e.g.
```
192.168.49.2    hostaway.lan
```
5. To access newly created k8s cluster set `KUBECONFIG` env to `~/.kube/minikube`

## How to use
Before you make any changes you need to change repository for _app of apps_ approach
1. Fork repository `https://github.com/g00ntar/apps.git` to your account
2. Change address of the repo in line 46 in `infra/live/*/apps/terragrunt.hcl` files
3. Change dir to `./live` and apply changes by running `terragrunt apply --queue-include-dir='*/apps'` 

### Deployment of new app
Add the argocd application manifest to a `apps/staging` in forked repo

### Promotion app to produton environment 
Copy argocd application manifest from `apps/staging` to a `apps/production`, remebmer to set difrent name and proper `project`, `namespace` and `targetRevision`.

### Rollback
To make quick rollback after bad deployment you can use `history and rollback` funcionality of argocd and choose one of previous from the list or change simply change `targetRevision` attribute in app manifest to desired branch or tag.

## Metrics 
### HTTP Request Latency
From user daily experience response time in my opinion have bigest impact because if it is to high over longer time website "feels laggy" and can indicates application overload.
- Warning: Avarage from 95th percentile over 5min shoud be lower than 250ms
- Critical: Avarage from 95th percentile over 5min shoud be lower than 500ms

### HTTP Error Rate (4xx/5xx)
Error rate should be monitored because it can quicky show problems with app deployment or configuration of infrastructure.
- Warning: Count of errors should be not higher then 1% of total count of request in 5min treshold
- Critical: 5% in 2min treshold

### Pod CPU and RAM usage
Basic metrics which allows to spot problems wth assigned resources for app or not enought count of replicas.
- CPU Warning: avarage cpu usage should be lower than 80% for 5min treshold (`resources.limits.cpu`)
- CPU Critical: avarage cpu usage should be lower than 90%
- RAM Warning: memory usage should be lower than 80% for 5min treshold (`resources.limits.memory`)
- RAM Critical: memeory usage should be lower than 90%

---
#### P.S.
1. Even if ArgoCD is internal use application there are (at least 2) solutions which allows to have ingress for it. One is usage of internal load balancer with vpn and second is zero trust network (Cloudflare have pretty good solution) and I have worked with both of them, so in my opinion it often depends from envirnonment in which solution is needed.  
