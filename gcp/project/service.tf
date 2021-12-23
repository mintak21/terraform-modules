## setup APIs
locals {
  basic_services = [
    "iam.googleapis.com",                  # Identity and Access Management (IAM) API
    "storage-component.googleapis.com",    # Cloud Storage API
    "compute.googleapis.com",              # Compute Engine API
    "cloudbuild.googleapis.com",           # Cloud Build API
    "container.googleapis.com",            # Kubernetes Engine API
    "cloudbilling.googleapis.com",         # Cloud Billing API
    "billingbudgets.googleapis.com",       # Cloud Billing Budget API
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "sts.googleapis.com",                  # Security Token Service API
  ]

  enable_services = setunion(local.basic_services, var.additional_enable_services)
}


resource "google_project_service" "this" {
  for_each = local.enable_services

  project                    = google_project.this.project_id
  service                    = each.value
  disable_dependent_services = true
  disable_on_destroy         = false

  depends_on = [
    google_project.this
  ]
}

