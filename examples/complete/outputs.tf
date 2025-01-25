#---------------------------------------------------
# Outputs GitHub Team
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team#attributes-reference

output "team_id" {
  description = <<EOF
  The ID of the created team.
EOF
  value       = try(module.team_configuration.team_id, "")
}

output "team_node_id" {
  description = <<EOF
  The Node ID of the created team.
EOF
  value       = try(module.team_configuration.team_node_id, "")
}

output "team_slug" {
  description = <<EOF
  The slug of the created team, which may or may not differ from `name`, depending on whether `name` contains "URL-unsafe" characters. Useful when referencing the team in [github_branch_protection](https://registry.terraform.io/docs/providers/github/r/branch_protection).
EOF
  value       = try(module.team_configuration.team_slug, "")
}

#---------------------------------------------------
# Outputs GitHub Team Membership
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership#attributes-reference

output "team_membership_memberships" {
  description = <<EOF
  The list of team memberships.
EOF
  value       = try(module.team_configuration.team_membership_memberships, [])
}

#---------------------------------------------------
# Outputs GitHub Team Repository
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository#attributes-reference

output "team_repository_repositories" {
  description = <<EOF
  The list of team repositories.
EOF
  value       = try(module.team_configuration.team_repository_repositories, [])
}
