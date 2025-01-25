#---------------------------------------------------
# Outputs GitHub Team Membership
#---------------------------------------------------
output "team_membership_memberships" {
  description = <<EOF
  The list of team memberships.
EOF
  value       = try(module.team_membership.team_membership_memberships, [])
}
