#---------------------------------------------------
# GitHub Team
#---------------------------------------------------
module "team" {
  source = "IbdaaiCloud/team/github"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  enable_team_creation           = true
  team_name                      = "DevOps"
  team_description               = "The DevOps team"
  team_privacy                   = "secret"
  team_parent_team_id            = null
  team_ldap_dn                   = null
  team_create_default_maintainer = false
}
