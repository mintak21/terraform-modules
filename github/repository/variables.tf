# required variables
variable "name" {
  type        = string
  description = "リポジトリ名称"
}

## for provider settings
variable "github_owner" {
  type        = string
  description = "github Owner名"
}

variable "github_token" {
  type        = string
  description = "github接続用トークン"
}

# variables which use default value if not specified
variable "description" {
  type        = string
  description = "リポジトリ説明"
  default     = "managed by terraform"
}

variable "is_private" {
  type        = bool
  description = "プライベートリポジトリとするか"
  default     = false
}

variable "has_issues" {
  type        = bool
  description = "Issueを発行するか"
  default     = false
}

variable "gitignore_template_type" {
  type        = string
  description = "リポジトリ作成時に作成するgitignoreの種別"
  default     = null
}

variable "secrets" {
  type        = map(string)
  description = "シークレット"
  default     = {}
}

variable "default_branch" {
  type        = string
  description = "デフォルトブランチ名称"
  default     = "main" # 最近はmainとなっている
}

variable "is_archive_on_destroy" {
  type        = bool
  description = "destroy時削除ではなくアーカイブとするか"
  default     = false
}

variable "is_git_flow" {
  type        = bool
  description = "Git Flowを採用するか（通常はGithub Flow）"
  default     = false
}

variable "has_default_branch_protection" {
  type        = bool
  description = "デフォルトブランチのプロテクト設定を行うか"
  default     = true
}

