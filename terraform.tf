terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
provider "github" {
  token = var.token
}
resource "github_repository" "api" {
  name        = "api"
  visibility  = "public"
  description = "Coffee API repository"
}

resource "github_branch_protection" "env_staging" {
  repository_id         = github_repository.api.node_id
  pattern               = "env/staging"
  enforce_admins        = true
  required_status_checks {
    strict   = true
  }
  required_pull_request_reviews {
    dismiss_stale_reviews      = true
  }
}

resource "github_branch_protection" "main" {
  repository_id         = github_repository.api.node_id
  pattern               = "main"
  enforce_admins        = true
  required_status_checks {
    strict   = true
  }
  required_pull_request_reviews {
    dismiss_stale_reviews      = true
  }
}