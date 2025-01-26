module "wrapper" {
  source = "../"

  for_each = var.items

  #---------------------------------------------------
  # GitHub Team
  #---------------------------------------------------
  enable_team_creation           = try(each.value.enable_team_creation, var.defaults.enable_team_creation, false)
  team_name                      = try(each.value.team_name, var.defaults.team_name, null)
  team_description               = try(each.value.team_description, var.defaults.team_description, null)
  team_privacy                   = try(each.value.team_privacy, var.defaults.team_privacy, null)
  team_parent_team_id            = try(each.value.team_parent_team_id, var.defaults.team_parent_team_id, null)
  team_ldap_dn                   = try(each.value.team_ldap_dn, var.defaults.team_ldap_dn, null)
  team_create_default_maintainer = try(each.value.team_create_default_maintainer, var.defaults.team_create_default_maintainer, null)

  #---------------------------------------------------
  # GitHub Team Membership
  #---------------------------------------------------
  enable_team_memberships_creation = try(each.value.enable_team_memberships_creation, var.defaults.enable_team_memberships_creation, false)
  team_membership_team_id          = try(each.value.team_membership_team_id, var.defaults.team_membership_team_id, null)
  team_membership_maintainers      = try(each.value.team_membership_maintainers, var.defaults.team_membership_maintainers, null)
  team_membership_members          = try(each.value.team_membership_members, var.defaults.team_membership_members, null)

  #---------------------------------------------------
  # GitHub Team Repository
  #---------------------------------------------------
  enable_repository_permissions_creation = try(each.value.enable_repository_permissions_creation, var.defaults.enable_repository_permissions_creation, false)
  team_repository_team_id                = try(each.value.team_repository_team_id, var.defaults.team_repository_team_id, null)
  team_repository_permissions = {
    admin    = try(each.value.team_repository_permissions.admin, var.defaults.team_repository_permissions.admin, [])
    maintain = try(each.value.team_repository_permissions.maintain, var.defaults.team_repository_permissions.maintain, [])
    push     = try(each.value.team_repository_permissions.push, var.defaults.team_repository_permissions.push, [])
    triage   = try(each.value.team_repository_permissions.triage, var.defaults.team_repository_permissions.triage, [])
    pull     = try(each.value.team_repository_permissions.pull, var.defaults.team_repository_permissions.pull, [])
  }
}
