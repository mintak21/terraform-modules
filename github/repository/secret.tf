resource "github_actions_secret" "secret" {
  for_each = var.secrets

  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}
