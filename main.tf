locals {
  team_membership_maintainers = {
    for username in var.team_membership_maintainers : lower(username) => {
      role     = "maintainer",
      username = username
    }
  }

  team_membership_members = {
    for username in setsubtract(var.team_membership_members, var.team_membership_maintainers) : lower(username) => {
      role     = "member",
      username = username
    }
  }

  team_membership_memberships = merge(
    local.team_membership_maintainers,
    local.team_membership_members
  )

  team_repository_permissions = {
    admin    = try(var.team_repository_permissions.admin, [])
    maintain = try(var.team_repository_permissions.maintain, [])
    push     = try(var.team_repository_permissions.push, [])
    triage   = try(var.team_repository_permissions.triage, [])
    pull     = try(var.team_repository_permissions.pull, [])
  }

  filtered_team_repository_permissions = {
    for role, repositories in local.team_repository_permissions : role => [
      for repository in coalesce(repositories, []) : repository if repository != null
    ] if length(coalesce(repositories, [])) > 0
  }

  team_repository_repositories = flatten([
    for role, repositories in local.filtered_team_repository_permissions : [
      for repository in repositories : {
        permission = role,
        repository = lower(repository)
      }
    ]
  ])

  team_repository_repositories_map = {
    for repo in local.team_repository_repositories : "${repo.repository}-${repo.permission}" => repo
  }

  team_membership_team_id = var.team_membership_team_id != null ? var.team_membership_team_id : (var.enable_team_creation ? try(element(github_team.this.*.id, 0), null) : null)
  team_repository_team_id = var.team_repository_team_id != null ? var.team_repository_team_id : (var.enable_team_creation ? try(element(github_team.this.*.id, 0), null) : null)
}

#---------------------------------------------------
# GitHub Team
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team

resource "github_team" "this" {
  count = var.enable_team_creation ? 1 : 0

  name                      = var.team_name
  description               = var.team_description
  privacy                   = var.team_privacy
  parent_team_id            = var.team_parent_team_id
  ldap_dn                   = var.team_ldap_dn
  create_default_maintainer = var.team_create_default_maintainer

  lifecycle {
    ignore_changes = [
      name,
      description,
      privacy,
      parent_team_id,
      ldap_dn,
      create_default_maintainer
    ]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Team ${self.name} is being destroyed'"
  }
}

resource "null_resource" "validate_team_name" {
  count = var.enable_team_creation && var.team_name == "" ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'Error: team_name must be provided when enable_team_creation is true' && exit 1"
  }
}

#---------------------------------------------------
# GitHub Team Membership
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership

resource "github_team_membership" "this" {
  for_each = var.enable_team_memberships && can(length(local.team_membership_memberships)) ? local.team_membership_memberships : {}

  team_id  = local.team_membership_team_id
  username = each.value.username
  role     = each.value.role
}

#---------------------------------------------------
# GitHub Team Repository
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository

resource "github_team_repository" "this" {
  for_each = var.enable_repository_permissions && can(length(local.team_repository_repositories_map)) ? local.team_repository_repositories_map : {}

  team_id    = local.team_repository_team_id
  repository = each.value.repository
  permission = each.value.permission
}
