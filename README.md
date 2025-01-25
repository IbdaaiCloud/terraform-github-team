<div align="center">
  <img src="https://raw.githubusercontent.com/IbdaaiCloud/terraform-github-team/refs/heads/main/.github/assets/img/banner.svg" alt="IbdaaiCloud - Terraform GitHub Team" />
</div>

<div align="center">
  <a href="https://github.com/IbdaaiCloud/terraform-github-team">
    <img src="https://img.shields.io/badge/github-%23181717.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
  <a href="https://registry.terraform.io/modules/IbdaaiCloud/github-team/latest">
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
  source  = "IbdaaiCloud/team/github"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  enable_team_creation           = true
  team_name                      = "DevOps"
  team_description               = "The DevOps team"
  team_privacy                   = "secret"
  team_parent_team_id            = null
  team_ldap_dn                   = null
  team_create_default_maintainer = false

  enable_team_memberships = true
  team_membership_maintainers = [
    "User0",
  ]
  team_membership_members = [
    "User1",
    "User2",
    "User3",
  ]

  enable_repository_permissions = true
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
    enable_team_creation           = true
    team_privacy                   = "secret"
    team_parent_team_id            = null
    team_ldap_dn                   = null
    team_create_default_maintainer = false
    enable_team_memberships        = true
    enable_repository_permissions  = true
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
    enable_team_creation           = true
    team_privacy                   = "secret"
    team_parent_team_id            = null
    team_ldap_dn                   = null
    team_create_default_maintainer = false
    enable_team_memberships        = true
    enable_repository_permissions  = true
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

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13.0 |
| <a name="requirement_github"></a> [github](#requirement_github)          | >= 6.4.0  |

## Providers

| Name                                                      | Version  |
| --------------------------------------------------------- | -------- |
| <a name="provider_github"></a> [github](#provider_github) | >= 6.4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [github_team.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team)                       | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_membership) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_repository) | resource |

## Inputs

| Name                                                                                                                        | Description                                                                                                                                                                                      | Type                                                                                                                                                            | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_enable_team_creation"></a> [enable_team_creation](#input_enable_team_creation)                               | (Optional) Whether to enable the creation of the GitHub team. Defaults to false.                                                                                                                 | `bool`                                                                                                                                                          | `false` |    no    |
| <a name="input_team_name"></a> [team_name](#input_team_name)                                                                | (Required) The name of the GitHub team.                                                                                                                                                          | `string`                                                                                                                                                        | n/a     |   yes    |
| <a name="input_team_description"></a> [team_description](#input_team_description)                                           | (Optional) The description of the GitHub team.                                                                                                                                                   | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_privacy"></a> [team_privacy](#input_team_privacy)                                                       | (Optional) The privacy level of the GitHub team. Can be one of `secret` or `closed`. Defaults to `secret`.                                                                                       | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_parent_team_id"></a> [team_parent_team_id](#input_team_parent_team_id)                                  | (Optional) The ID of the parent team for this team.                                                                                                                                              | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_ldap_dn"></a> [team_ldap_dn](#input_team_ldap_dn)                                                       | (Optional) The LDAP Distinguished Name (DN) to bind to the GitHub team.                                                                                                                          | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_create_default_maintainer"></a> [team_create_default_maintainer](#input_team_create_default_maintainer) | (Optional) Whether to create a default maintainer for the GitHub team. Defaults to false.                                                                                                        | `bool`                                                                                                                                                          | `false` |    no    |
| <a name="input_enable_team_memberships"></a> [enable_team_memberships](#input_enable_team_memberships)                      | (Optional) Whether to enable the management of team memberships. Defaults to false.                                                                                                              | `bool`                                                                                                                                                          | `false` |    no    |
| <a name="input_team_membership_team_id"></a> [team_membership_team_id](#input_team_membership_team_id)                      | (Optional) The ID of the GitHub team for which to manage memberships.                                                                                                                            | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_membership_maintainers"></a> [team_membership_maintainers](#input_team_membership_maintainers)          | (Optional) A list of usernames to be added as maintainers to the GitHub team.                                                                                                                    | `list(string)`                                                                                                                                                  | `[]`    |    no    |
| <a name="input_team_membership_members"></a> [team_membership_members](#input_team_membership_members)                      | (Optional) A list of usernames to be added as members to the GitHub team.                                                                                                                        | `list(string)`                                                                                                                                                  | `[]`    |    no    |
| <a name="input_enable_repository_permissions"></a> [enable_repository_permissions](#input_enable_repository_permissions)    | (Optional) Whether to enable the management of repository permissions for the GitHub team. Defaults to false.                                                                                    | `bool`                                                                                                                                                          | `false` |    no    |
| <a name="input_team_repository_team_id"></a> [team_repository_team_id](#input_team_repository_team_id)                      | (Optional) The ID of the GitHub team for which to manage repository permissions.                                                                                                                 | `string`                                                                                                                                                        | `null`  |    no    |
| <a name="input_team_repository_permissions"></a> [team_repository_permissions](#input_team_repository_permissions)          | (Optional) A map of repository permissions for the GitHub team. The keys are the permission levels (`admin`, `maintain`, `push`, `triage`, `pull`) and the values are lists of repository names. | <pre>object({<br/> admin = list(string)<br/> maintain = list(string)<br/> push = list(string)<br/> triage = list(string)<br/> pull = list(string)<br/> })</pre> | `{}`    |    no    |

## Outputs

| Name                                                                                                                          | Description                                                                                                                           |
| ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| <a name="output_team_id"></a> [team_id](#output_team_id)                                                                      | The ID of the GitHub team.                                                                                                            |
| <a name="output_team_name"></a> [team_name](#output_team_name)                                                                | The name of the GitHub team.                                                                                                          |
| <a name="output_team_description"></a> [team_description](#output_team_description)                                           | The description of the GitHub team.                                                                                                   |
| <a name="output_team_privacy"></a> [team_privacy](#output_team_privacy)                                                       | The privacy level of the GitHub team.                                                                                                 |
| <a name="output_team_parent_team_id"></a> [team_parent_team_id](#output_team_parent_team_id)                                  | The ID of the parent team for this team.                                                                                              |
| <a name="output_team_ldap_dn"></a> [team_ldap_dn](#output_team_ldap_dn)                                                       | The LDAP Distinguished Name (DN) of the GitHub team.                                                                                  |
| <a name="output_team_create_default_maintainer"></a> [team_create_default_maintainer](#output_team_create_default_maintainer) | Whether a default maintainer was created for the GitHub team.                                                                         |
| <a name="output_team_membership_team_id"></a> [team_membership_team_id](#output_team_membership_team_id)                      | The ID of the GitHub team for which memberships are managed.                                                                          |
| <a name="output_team_membership_maintainers"></a> [team_membership_maintainers](#output_team_membership_maintainers)          | A list of usernames added as maintainers to the GitHub team.                                                                          |
| <a name="output_team_membership_members"></a> [team_membership_members](#output_team_membership_members)                      | A list of usernames added as members to the GitHub team.                                                                              |
| <a name="output_team_repository_team_id"></a> [team_repository_team_id](#output_team_repository_team_id)                      | The ID of the GitHub team for which repository permissions are managed.                                                               |
| <a name="output_team_repository_permissions"></a> [team_repository_permissions](#output_team_repository_permissions)          | A map of repository permissions for the GitHub team. The keys are the permission levels and the values are lists of repository names. |

<!-- END_TF_DOCS -->

## License

This work is licensed under MIT License. See [LICENSE](LICENSE) for full details.

## Authors

This module is maintained by the IbdaaiCloud team.
