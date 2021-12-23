resource "google_service_account" "github_actions" {
  project      = google_project.this.project_id
  account_id   = "github-actions"
  display_name = "github actions"
  description  = "link to Workload Identity Pool used by github actions"
}

resource "google_project_iam_member" "github_actions" {
  project = google_project.this.project_id
  role    = "roles/editor" // FIXME 本来は個別に権限をふるべき
  member  = "ServiceAccount:${google_service_account.github_actions.email}"
}

resource "google_service_account_iam_member" "github_actions" {
  project            = google_project.this.project_id
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.id}/attribute.owner/${var.authorize_github_owner}"
}

resource "google_project_default_service_accounts" "this" {
  project        = google_project.this.project_id
  action         = "DISABLE"
  restore_policy = "REVERT"

  depends_on = [
    google_project.this
  ]
}
