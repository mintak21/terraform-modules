terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.3.0"
      # 4.3.1はバグあり https://github.com/integrations/terraform-provider-github/issues/678
    }
  }
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}
