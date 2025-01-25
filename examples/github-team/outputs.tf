#---------------------------------------------------
# Outputs GitHub Team
#---------------------------------------------------
output "team_id" {
  description = <<EOF
  The ID of the created team.
EOF
  value       = try(module.team.team_id, "")
}

output "team_node_id" {
  description = <<EOF
  The Node ID of the created team.
EOF
  value       = try(module.team.team_node_id, "")
}

output "team_slug" {
  description = <<EOF
  The slug of the created team, which may or may not differ from `name`, depending on whether `name` contains "URL-unsafe" characters. Useful when referencing the team in [github_branch_protection](https://registry.terraform.io/docs/providers/github/r/branch_protection).
EOF
  value       = try(module.team.team_slug, "")
}
