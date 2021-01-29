resource "github_branch" "develop" {
  count = var.is_git_flow ? 1 : 0

  repository = github_repository.this.name
  branch     = "develop"
}

resource "github_branch_default" "develop_default" {
  count = var.is_git_flow ? 1 : 0

  repository = github_repository.this.name
  branch     = "develop"

  depends_on = [
    github_branch.develop
  ]
}

resource "github_branch_protection" "protection" {
  count = var.has_default_branch_protection ? 1 : 0

  repository_id    = github_repository.this.name
  pattern          = var.default_branch
  enforce_admins   = false
  allows_deletions = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }
}
