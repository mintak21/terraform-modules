variable "cluster_name" {
  type        = string
  description = "クラスタ名"
}

variable "machine_type" {
  type        = string
  description = "ノードマシン種別"
}

# use default values
variable "cluster_location" {
  type        = string
  description = "GKEロケーション"
  default     = "us-central1"
}

variable "autoscale_max_node" {
  type        = integer
  description = "オートスケール最大ノード数"
  default     = 3
}

variable "master_ip_range" {
  type        = string
  description = "マスターIPレンジ See.https://future-architect.github.io/articles/20191017/"
  default     = "192.168.0.0/28"
}

variable "pod_ip_range" {
  type        = string
  description = "PodIPレンジ"
  default     = "172.16.0.0/18"
}

variable "service_ip_range" {
  type        = string
  description = "ServiceIPレンジ"
  default     = "172.18.0.0/18"
}

variable "vpc_subnetwork_primary_ip_range" {
  type        = string
  description = "サブネットのプライマリIPレンジ"
  default     = "10.128.0.0/24"
}
