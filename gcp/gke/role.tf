resource "google_project_iam_binding" "gke_role_binding" {
  role = google_project_iam_custom_role.role_for_gke.name
  members = [
    "serviceAccount:${google_service_account.sa_for_gke.email}",
  ]
}

resource "google_service_account" "sa_for_gke" {
  account_id   = "gke-${var.cluster_name}"
  display_name = "Google Kubernetes Engine (${var.cluster_name}) service account"
  description  = "Google Kubernetes Engine (${var.cluster_name})に設定するサービスアカウント"
}

resource "google_project_iam_custom_role" "role_for_gke" {
  role_id     = "gke_${var.cluster_name}_${random_string.role_prefix.result}"
  title       = "${var.cluster_name} Kubernetes Engine"
  description = "Custom Role For Google Kubernetes Engine (${var.cluster_name})"
  # 最低限、monitoring.viewer、monitoring.metricWriter、logging.logWriterの3つのロール（に紐づく権限）が必要
  # See. https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster?hl=ja#use_least_privilege_sa
  permissions = [
    ## roles/logging.logWriter
    "logging.logEntries.create",
    ## roles/monitoring.metricWriter
    "monitoring.metricDescriptors.create",
    "monitoring.metricDescriptors.get",
    "monitoring.metricDescriptors.list",
    "monitoring.monitoredResourceDescriptors.get",
    "monitoring.monitoredResourceDescriptors.list",
    "monitoring.timeSeries.create",
    ## roles/monitoring.viewer
    "monitoring.alertPolicies.get",
    "monitoring.alertPolicies.list",
    "monitoring.dashboards.get",
    "monitoring.dashboards.list",
    "monitoring.groups.get",
    "monitoring.groups.list",
    "monitoring.notificationChannelDescriptors.get",
    "monitoring.notificationChannelDescriptors.list",
    "monitoring.notificationChannels.get",
    "monitoring.notificationChannels.list",
    "monitoring.publicWidgets.get",
    "monitoring.publicWidgets.list",
    "monitoring.services.get",
    "monitoring.services.list",
    "monitoring.slos.get",
    "monitoring.slos.list",
    "monitoring.timeSeries.list",
    "monitoring.uptimeCheckConfigs.get",
    "monitoring.uptimeCheckConfigs.list",
    "opsconfigmonitoring.resourceMetadata.list",
    "resourcemanager.projects.get",
    # "resourcemanager.projects.list", # カスタムロールには付与できない権限
    "stackdriver.projects.get",
  ]
}

resource "random_string" "role_prefix" {
  length  = 4
  upper   = false
  lower   = true
  number  = true
  special = false
}
