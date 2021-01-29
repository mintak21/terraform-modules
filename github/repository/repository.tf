resource "github_repository" "this" {
  name        = var.name
  description = var.description

  visibility           = var.is_private ? "private" : "public"
  has_issues           = var.has_issues
  has_projects         = false
  has_wiki             = false
  is_template          = false
  allow_merge_commit   = true
  allow_squash_merge   = true
  allow_rebase_merge   = false
  has_downloads        = false
  auto_init            = true
  vulnerability_alerts = true
  gitignore_template   = var.gitignore_template_type

  archive_on_destroy = var.is_archive_on_destroy
}
