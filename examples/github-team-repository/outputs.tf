#---------------------------------------------------
# Outputs GitHub Team Repository
#---------------------------------------------------
output "team_repository_repositories" {
  description = <<EOF
  The list of team repositories.
EOF
  value       = try(module.team_repository.team_repository_repositories, [])
}
