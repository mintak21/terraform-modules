resource "google_iam_workload_identity_pool" "github" {
  provider                  = google-beta
  project                   = google_project.this.project_id
  workload_identity_pool_id = "github"
  display_name              = "github"
  description               = "for github actions"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  provider                           = google-beta
  project                            = google_project.this.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "github actions provider"
  description                        = "OIDC identity pool provider for execute github actions"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.owner"      = "assertion.repository_owner"
    "attribute.refs"       = "assertion.ref"
  }
  attribute_condition = var.attribute_condition

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
