terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "pradeepreddy-hub"
}

resource "github_repository" "repos" {
  for_each = toset([
    "repo-Dev",
    "repo-Test",
    "repo-Prod"
  ])

  name       = each.value
  visibility = "public"
  auto_init = true
}
