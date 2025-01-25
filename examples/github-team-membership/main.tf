#---------------------------------------------------
# GitHub Team
#---------------------------------------------------
resource "github_team" "this" {
  name        = "QA Team"
  description = "This is the QA team."
}

#---------------------------------------------------
# GitHub Team Membership
#---------------------------------------------------
module "team_membership" {
  source = "../../"

  enable_team_memberships = true
  team_membership_team_id = github_team.this.id
  team_membership_maintainers = [
    "User0",
  ]
  team_membership_members = [
    "User1",
    "User2",
    "User3",
  ]

  depends_on = [
    github_team.this
  ]
}
