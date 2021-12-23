variable "name" {
  type        = string
  description = "プロジェクト名称"
}

variable "billing_account_id" {
  type        = string
  description = "請求先アカウントID"
}

variable "additional_enable_services" {
  type        = set(string)
  description = "追加で有効にするAPIサービスリスト"
  default = []
}
