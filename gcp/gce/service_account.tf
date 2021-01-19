resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = "gce-${var.instance_name}"
  display_name = "Google Compute Engine (${var.instance_name}) service account"
  description  = "Google Compute Engine (${var.instance_name})に設定するサービスアカウント"
}
