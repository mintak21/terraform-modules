resource "google_container_cluster" "vpc_native_zonal_cluster" {
  provider = google-beta

  name        = var.cluster_name
  project     = data.google_project.project.project_id
  description = "Cluster for ${var.cluster_name}"
  location    = "${var.cluster_location}-a" # Zonal Cluster

  networking_mode = "VPC_NATIVE"
  network         = google_compute_network.nw_for_gke.id
  subnetwork      = google_compute_subnetwork.subnw_for_gke.id

  enable_binary_authorization = false
  enable_kubernetes_alpha     = false
  enable_tpu                  = false
  enable_legacy_abac          = false
  enable_shielded_nodes       = true

  # Terraform推奨 デフォルトで作られるノードプールは破棄、ノードプールもterraformで管理する
  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # See. https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters?hl=ja
    master_ipv4_cidr_block  = var.master_ip_range
  }

  addons_config {
    dns_cache_config {
      enabled = true
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.cluster_name}-pod-ip-range"
    services_secondary_range_name = "${var.cluster_name}-service-ip-range"
  }

  workload_identity_config {
    identity_namespace = "${data.google_project.project.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  # tfsec: Disable basic auth with static passwords for client authentication with a master_auth block container empty strings for user and password.
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # # tfsec: It is recommended to define a PSP for your pods and enable PSP enforcement.
  # pod_security_policy_config {
  #   enabled = true
  # }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "18:00" # JST 03:00 / 曜日までは指定できない
    }
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "15m"
    update = "10m"
    delete = "15m"
  }

  depends_on = [
    google_compute_network.nw_for_gke,
    google_compute_subnetwork.subnw_for_gke,
    google_service_account.sa_for_gke,
  ]
}

resource "google_container_node_pool" "vpc_native_cluster_nodes" {
  provider = google-beta

  name       = "terraform"
  location   = google_container_cluster.vpc_native_cluster.location
  cluster    = google_container_cluster.vpc_native_cluster.name
  node_count = 1

  node_config {
    image_type      = "COS_CONTAINERD"
    machine_type    = var.machine_type
    preemptible     = true
    service_account = google_service_account.sa_for_gke.email

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = 0
    max_node_count = var.autoscale_max_node
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}

data "google_project" "project" {
}
