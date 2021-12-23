output "project_id" {
  description = "プロジェクトID"
  value       = google_project.this.project_id
}

output "service_account_github_actions_email" {
  description = "Actionsで使用するサービスアカウント"
  value       = google_service_account.github_actions.email
}

output "iam_workload_identity_pool_github_name" {
  description = "Workload Identity Pood ID"
  value       = google_iam_workload_identity_pool.github.name
}

output "google_iam_workload_identity_pool_provider_github_name" {
  description = "Workload Identity Pood Provider ID"
  value       = google_iam_workload_identity_pool_provider.github.name
}
