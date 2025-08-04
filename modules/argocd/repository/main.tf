resource "argocd_repository" "this" {
  for_each = { for v in var.repos : trimsuffix(trimprefix(v.url, "git@github.com:"), ".git") => v }
  
  name            = each.key
  repo            = each.value.url
  username        = "git"
  ssh_private_key = each.value.key
}