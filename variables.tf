#---------------------------------------------------
# Variables Environment
#---------------------------------------------------

variable "enable_team_creation" {
  type        = bool
  description = <<EOF
  (Required) Whether the team should be enabled. Defaults to false. If set to true, the team will be created.
EOF
  default     = false
}

variable "enable_team_memberships_creation" {
  type        = bool
  description = <<EOF
  (Required) Whether the team memberships should be enabled. Defaults to false. If set to true, the team memberships will be created.
EOF
  default     = false
}

variable "enable_repository_permissions_creation" {
  type        = bool
  description = <<EOF
  (Required) Whether the team repository permissions should be enabled. Defaults to false. If set to true, the team repository permissions will be created.
EOF
  default     = false
}

#---------------------------------------------------
# Variables GitHub Team
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team#attributes-reference

variable "team_name" {
  type        = string
  description = <<EOF
  (Required) The name of the team.
EOF
  default     = null
}

variable "team_description" {
  type        = string
  description = <<EOF
  (Optional) The description of the team.
EOF
  default     = null
}

variable "team_privacy" {
  type        = string
  description = <<EOF
  (Optional) The level of privacy for the team. Must be one of `secret` or `closed`. Defaults to `secret`.
EOF
  default     = "secret"
  validation {
    condition     = contains(["secret", "closed"], var.team_privacy)
    error_message = "The team_privacy variable must be either 'secret' or 'closed'."
  }
}

variable "team_parent_team_id" {
  type        = number
  description = <<EOF
  (Optional) The ID or slug of the parent team, if this is a nested team.
EOF
  default     = null
}

variable "team_ldap_dn" {
  type        = string
  description = <<EOF
  (Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server.
EOF
  default     = null
}

variable "team_create_default_maintainer" {
  type        = bool
  description = <<EOF
  (Optional) Adds a default maintainer to the team. Defaults to `false` and adds the creating user to the team when `true`.
EOF
  default     = false
}

#---------------------------------------------------
# Variables GitHub Team Membership
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership#attributes-reference

variable "team_membership_team_id" {
  type        = number
  description = <<EOF
  (Required) The GitHub team id or the GitHub team slug to add the members to.
EOF
  default     = null
}

variable "team_membership_maintainers" {
  type        = list(string)
  description = <<EOF
  (Required) The list of maintainers to add to the team.
EOF
  default     = []
}

variable "team_membership_members" {
  type        = list(string)
  description = <<EOF
  (Required) The list of members to add to the team.
EOF
  default     = []
}

#---------------------------------------------------
# Variables GitHub Team Repository
#---------------------------------------------------

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository#attributes-reference

variable "team_repository_team_id" {
  type        = number
  description = <<EOF
  (Required) The GitHub team id or the GitHub team slug to add the repositories to.
EOF
  default     = null
}

variable "team_repository_permissions" {
  type = object({
    admin    = list(string)
    maintain = list(string)
    push     = list(string)
    triage   = list(string)
    pull     = list(string)
  })
  description = <<EOF
  (Required) The list of repositories to add to the team with specific permissions. The key is the permission and the value is the list of repositories. The permissions must be one of `admin`, `maintain`, `push`, `triage`, or `pull`.

  admin    - (Optional) The list of repositories that the team has admin access to.
  maintain - (Optional) The list of repositories that the team has maintain access to.
  push     - (Optional) The list of repositories that the team has push access to.
  triage   - (Optional) The list of repositories that the team has triage access to.
  pull     - (Optional) The list of repositories that the team has pull access to.
EOF
  default = {
    admin    = []
    maintain = []
    push     = []
    triage   = []
    pull     = []
  }
}
