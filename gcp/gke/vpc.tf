resource "google_compute_network" "nw_for_gke" {
  name                    = "${var.cluster_name}-network"
  description             = "VPC Network For Locating Private Google Kubernetes Cluster - ${var.cluster_name}"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnw_for_gke" {
  name                     = "${var.cluster_name}-subnet"
  network                  = google_compute_network.nw_for_gke.id
  description              = "VPC SubNetwork For Locating Private Google Kubernetes Cluster - ${var.cluster_name}"
  region                   = var.cluster_location
  ip_cidr_range            = var.vpc_subnetwork_primary_ip_range
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.cluster_name}-pod-ip-range"
    ip_cidr_range = var.pod_ip_range
  }
  secondary_ip_range {
    range_name    = "${var.cluster_name}-service-ip-range"
    ip_cidr_range = var.service_ip_range
  }

  depends_on = [
    google_compute_network.nw_for_gke,
  ]
}

