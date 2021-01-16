output "cluster_id" {
  value       = google_container_cluster.vpc_native_cluster.id
  description = "作成したクラスタのID"
}

output "kubernetes_master_version" {
  value       = google_container_cluster.vpc_native_cluster.master_version
  description = "作成したクラスタのマスターバージョン"
}

output "nodepool_id" {
  value       = google_container_node_pool.vpc_native_cluster_nodes.id
  description = "作成したノードプールのID"
}

output "vpc_network_id" {
  value       = google_compute_network.nw_for_gke.id
  description = "作成したVPCネットワークのID"
}

output "vpc_subnetwork_id" {
  value       = google_compute_subnetwork.subnw_for_gke.id
  description = "作成したサブネットのID"
}
