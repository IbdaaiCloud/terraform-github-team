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
# Module Team Configuration
#---------------------------------------------------
module "team_configuration" {
  source = "IbdaaiCloud/team/github"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  #---------------------------------------------------
  # GitHub Team
  #---------------------------------------------------
  enable_team_creation           = true
  team_name                      = "DevOps"
  team_description               = "The DevOps team"
  team_privacy                   = "secret"
  team_parent_team_id            = null
  team_ldap_dn                   = null
  team_create_default_maintainer = false

  #---------------------------------------------------
  # GitHub Team Membership
  #---------------------------------------------------
  enable_team_memberships_creation = true
  team_membership_maintainers = [
    "User0",
  ]
  team_membership_members = [
    "User1",
    "User2",
    "User3",
  ]

  #---------------------------------------------------
  # GitHub Team Repository
  #---------------------------------------------------
  enable_repository_permissions_creation = true
  team_repository_permissions = {
    admin    = [github_repository.qa_repo.name]
    maintain = [github_repository.py_dev_repo.name]
    push     = [github_repository.js_dev_repo.name]
    triage   = []
    pull     = []
  }
}
