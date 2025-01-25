#---------------------------------------------------
# GitHub Team
#---------------------------------------------------
resource "github_team" "qa_team" {
  name        = "QA Team"
  description = "This is the QA team."
}

#---------------------------------------------------
# GitHub Repository
#---------------------------------------------------
resource "github_repository" "qa_repo" {
  name        = "qa-repo"
  description = "This is the QA repository."
}

resource "github_repository" "py_dev_repo" {
  name        = "python-dev-repo"
  description = "This is the Python Developers repository."
}

resource "github_repository" "js_dev_repo" {
  name        = "javascript-dev-repo"
  description = "This is the JavaScript Developers repository."
}

#---------------------------------------------------
# GitHub Team Repository
#---------------------------------------------------
module "team_repository" {
  source = "IbdaaiCloud/team/github"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  enable_repository_permissions = true
  team_repository_team_id       = github_team.qa_team.id
  team_repository_permissions = {
    admin    = [github_repository.qa_repo.name]
    maintain = [github_repository.py_dev_repo.name]
    push     = [github_repository.js_dev_repo.name]
    triage   = []
    pull     = []
  }
}
