resource "google_compute_instance" "this" {
  provider     = google-beta
  project      = var.project_id
  name         = var.instance_name
  description  = "A Compute VM managed by Terraform"
  machine_type = var.machine_type
  zone         = var.instance_location

  allow_stopping_for_update = true
  deletion_protection       = false

  boot_disk {
    auto_delete       = true
    kms_key_self_link = kms_key_link
    initialize_params {
      image = var.boot_disk.image
      type  = var.boot_disk.type
      size  = var.boot_disk.size
    }
  }

  dynamic "network_interface" {
    // TODO create dynamic block
    for_each = var.network
  }

  scheduling {
    automatic_restart   = !var.preemptible
    on_host_maintenance = var.preemptible ? "TERMINATE" : "MIGRATE"
    preemptible         = var.preemptible
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.this.email
    scopes = ["cloud-platform"]
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
