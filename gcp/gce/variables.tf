## Required variables
variable "project_id" {
  type        = string
  description = "作成するプロジェクトのID"
}

variable "instance_name" {
  type        = string
  description = "インスタンス名"
}

variable "network" {
  description = "ネットワーク設定"
  type = list(object({
    nat        = bool
    network    = string
    subnetwork = string
    addresses = object({
      internal = list(string)
      external = list(string)
    })
    alias_ips = map(list(string))
  }))
}

## variables which use default value if not specified
variable "machine_type" {
  type        = string
  description = "インスタンスマシン種別"
  default     = "f1-micro"
}

variable "instance_location" {
  type        = string
  description = "インスタンス配置ゾーン"
  default     = "us-central1-a"
}

variable "boot_disk" {
  description = "ディスクベースイメージ"
  type = object({
    image = string
    type  = string
    size  = number
  })
  default = {
    image = "debian-cloud/debian-10"
    type  = "pd-standard"
    size  = 10
  }
}

variable "kms_key_link" {
  description = "boot disk暗号化に利用するKMSキーリンク"
  type        = string
  default     = null
}

variable "preemptible" {
  description = "プリエンプティブル設定の可否"
  type        = bool
  default     = false
}
