resource "github_repository" "repo" {
  name        = var.repo_name
  description = ""

  visibility = var.visibility

  template {
    owner      = "TorbFoundry"
    repository = "torb-user-project-template"
  }
}