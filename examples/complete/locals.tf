locals {
  # GitHub token with the following permissions:
  # https://github.com/settings/tokens/new
  # Select the following permissions:
  # - repo            : Full control of private repositories
  # - admin:repo_hook : Full control of repository hooks
  # - admin:org_hook  : Full control of organization hooks (if the repository is part of an organization)
  github_token = "REPLACE_ME_WITH_GITHUB_TOKEN"
  # GitHub organization of the repository
  github_organization = "REPLACE_ME_WITH_GITHUB_ORGANIZATION"
}
