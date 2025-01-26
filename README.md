<div align="center">
  <img src="https://raw.githubusercontent.com/IbdaaiCloud/terraform-github-team/refs/heads/main/.github/assets/img/banner.svg" alt="IbdaaiCloud - Terraform GitHub Team" />
</div>

<div align="center">
  <a href="https://github.com/IbdaaiCloud/terraform-github-team">
    <img src="https://img.shields.io/badge/github-%23181717.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
  <a href="https://registry.terraform.io/modules/IbdaaiCloud/team/github/latest">
    <img src="https://img.shields.io/github/v/release/IbdaaiCloud/terraform-github-team?color=blue&label=terraform&logo=terraform&style=for-the-badge" alt="Terraform Registry"/>
  </a>
  <a href="https://github.com/IbdaaiCloud/terraform-github-team/releases">
    <img src="https://img.shields.io/github/v/release/IbdaaiCloud/terraform-github-team?include_prereleases&sort=date&style=for-the-badge" alt="GitHub Releases"/>
  </a>
  <a href="https://github.com/IbdaaiCloud/terraform-github-team/stargazers">
    <img src="https://img.shields.io/github/stars/IbdaaiCloud/terraform-github-team.svg?style=for-the-badge" alt="GitHub Stars"/>
  </a>
  <a href="https://github.com/IbdaaiCloud/terraform-github-team/forks">
    <img src="https://img.shields.io/github/forks/IbdaaiCloud/terraform-github-team.svg?style=for-the-badge" alt="GitHub Forks"/>
  </a>
  <a href="https://github.com/IbdaaiCloud/terraform-github-team/issues">
    <img src="https://img.shields.io/github/issues/IbdaaiCloud/terraform-github-team.svg?style=for-the-badge" alt="GitHub Issues"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/IbdaaiCloud/terraform-github-team.svg?style=for-the-badge" alt="GitHub License"/>
  </a>
</div>

# Terraform GitHub Team

## Description

This repository contains Terraform modules for managing GitHub teams, team memberships, and team repository permissions. The module allows you to create, update, and delete GitHub teams, manage team memberships, and set repository permissions for teams.

## Usage

### Module

The following example demonstrates how to use the module to create a GitHub team, manage its memberships, and set repository permissions.

```hcl
module "github_team" {
  source = "IbdaaiCloud/team/github"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  enable_team_creation           = true
  team_name                      = "DevOps"
  team_description               = "The DevOps team"
  team_privacy                   = "secret"
  team_parent_team_id            = null
  team_ldap_dn                   = null
  team_create_default_maintainer = false

  enable_team_memberships_creation = true
  team_membership_maintainers = [
    "User0",
  ]
  team_membership_members = [
    "User1",
    "User2",
    "User3",
  ]

  enable_repository_permissions_creation = true
  team_repository_permissions = {
    admin    = ["repo1"]
    maintain = ["repo2"]
    push     = ["repo3"]
    triage   = []
    pull     = []
  }
}
```

> [!WARNING]
> The `version` argument is omitted in the example's `source` block. It is strongly recommended to specify a version to ensure stability and avoid unexpected changes due to future updates. Use a version constraint like `version = "~> x.x.x"` in your project to lock the module to a compatible release.

### Wrapper Module

The wrapper module provided here offers a convenient solution for managing multiple instances of the GitHub team module in scenarios where the native `for_each` feature introduced in `Terraform 0.13+` cannot be utilized, such as when working with Terragrunt.

This approach allows you to consolidate configurations into a single Terragrunt file, effectively managing multiple resources without duplicating `terragrunt.hcl` files for each instance of the module.

The wrapper is designed purely as a utility for orchestrating multiple modules and does not add any extra functionality beyond simplifying the configuration process.

#### Example Usage with Terraform

```hcl
module "github_team_wrapper" {
  source = "IbdaaiCloud/team/github//wrapper"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  defaults = {
    enable_team_creation                   = true
    team_privacy                           = "secret"
    team_parent_team_id                    = null
    team_ldap_dn                           = null
    team_create_default_maintainer         = false
    enable_team_memberships_creation       = true
    enable_repository_permissions_creation = true
    team_repository_permissions = {
      admin    = []
      maintain = []
      push     = []
      triage   = []
      pull     = []
    }
  }

  items = {
    "team-example-1" = {
      # omitted... can be any arguments supported by the module
    }
    "team-example-2" = {
      # omitted... can be any arguments supported by the module
    }
    "team-example-3" = {
      # omitted... can be any arguments supported by the module
    }
  }
}
```

#### Example Usage with Terragrunt

```hcl
terraform {
  source = "IbdaaiCloud/github-team//wrapper"
  # version = "x.y.z" # Use the latest version from the Terraform Registry
}

inputs = {
  defaults = {
    enable_team_creation                   = true
    team_privacy                           = "secret"
    team_parent_team_id                    = null
    team_ldap_dn                           = null
    team_create_default_maintainer         = false
    enable_team_memberships_creation       = true
    enable_repository_permissions_creation = true
    team_repository_permissions = {
      admin    = []
      maintain = []
      push     = []
      triage   = []
      pull     = []
    }
  }

  items = {
    "team-example-1" = {
      # omitted... can be any arguments supported by the module
    }
    "team-example-2" = {
      # omitted... can be any arguments supported by the module
    }
    "team-example-3" = {
      # omitted... can be any arguments supported by the module
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

## Providers

## Modules

No modules.

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->

## License

This work is licensed under MIT License. See [LICENSE](LICENSE) for full details.

## Authors

This module is maintained by the IbdaaiCloud team.
