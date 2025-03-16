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

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13.0 |
| <a name="requirement_github"></a> [github](#requirement_github)          | >= 6.6.0  |
| <a name="requirement_null"></a> [null](#requirement_null)                | >= 3.2.3  |

## Providers

| Name                                                      | Version  |
| --------------------------------------------------------- | -------- |
| <a name="provider_github"></a> [github](#provider_github) | >= 6.6.0 |
| <a name="provider_null"></a> [null](#provider_null)       | >= 3.2.3 |

## Modules

No modules.

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [github_team.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team)                       | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_membership) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_repository) | resource |
| [null_resource.validate_team_name](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)     | resource |

## Inputs

| Name                                                                                                                                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Type                                                                                                                                                            | Default                                                                                                       | Required |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_enable_repository_permissions_creation"></a> [enable_repository_permissions_creation](#input_enable_repository_permissions_creation) | (Required) Whether the team repository permissions should be enabled. Defaults to false. If set to true, the team repository permissions will be created.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `bool`                                                                                                                                                          | `false`                                                                                                       |    no    |
| <a name="input_enable_team_creation"></a> [enable_team_creation](#input_enable_team_creation)                                                       | (Required) Whether the team should be enabled. Defaults to false. If set to true, the team will be created.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `bool`                                                                                                                                                          | `false`                                                                                                       |    no    |
| <a name="input_enable_team_memberships_creation"></a> [enable_team_memberships_creation](#input_enable_team_memberships_creation)                   | (Required) Whether the team memberships should be enabled. Defaults to false. If set to true, the team memberships will be created.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `bool`                                                                                                                                                          | `false`                                                                                                       |    no    |
| <a name="input_team_create_default_maintainer"></a> [team_create_default_maintainer](#input_team_create_default_maintainer)                         | (Optional) Adds a default maintainer to the team. Defaults to `false` and adds the creating user to the team when `true`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `bool`                                                                                                                                                          | `false`                                                                                                       |    no    |
| <a name="input_team_description"></a> [team_description](#input_team_description)                                                                   | (Optional) The description of the team.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `string`                                                                                                                                                        | `null`                                                                                                        |    no    |
| <a name="input_team_ldap_dn"></a> [team_ldap_dn](#input_team_ldap_dn)                                                                               | (Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `string`                                                                                                                                                        | `null`                                                                                                        |    no    |
| <a name="input_team_membership_maintainers"></a> [team_membership_maintainers](#input_team_membership_maintainers)                                  | (Required) The list of maintainers to add to the team.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `list(string)`                                                                                                                                                  | `[]`                                                                                                          |    no    |
| <a name="input_team_membership_members"></a> [team_membership_members](#input_team_membership_members)                                              | (Required) The list of members to add to the team.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `list(string)`                                                                                                                                                  | `[]`                                                                                                          |    no    |
| <a name="input_team_membership_team_id"></a> [team_membership_team_id](#input_team_membership_team_id)                                              | (Required) The GitHub team id or the GitHub team slug to add the members to.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `number`                                                                                                                                                        | `null`                                                                                                        |    no    |
| <a name="input_team_name"></a> [team_name](#input_team_name)                                                                                        | (Required) The name of the team.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `string`                                                                                                                                                        | `null`                                                                                                        |    no    |
| <a name="input_team_parent_team_id"></a> [team_parent_team_id](#input_team_parent_team_id)                                                          | (Optional) The ID or slug of the parent team, if this is a nested team.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `number`                                                                                                                                                        | `null`                                                                                                        |    no    |
| <a name="input_team_privacy"></a> [team_privacy](#input_team_privacy)                                                                               | (Optional) The level of privacy for the team. Must be one of `secret` or `closed`. Defaults to `secret`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `string`                                                                                                                                                        | `"secret"`                                                                                                    |    no    |
| <a name="input_team_repository_permissions"></a> [team_repository_permissions](#input_team_repository_permissions)                                  | (Required) The list of repositories to add to the team with specific permissions. The key is the permission and the value is the list of repositories. The permissions must be one of `admin`, `maintain`, `push`, `triage`, or `pull`.<br/><br/> admin - (Optional) The list of repositories that the team has admin access to.<br/> maintain - (Optional) The list of repositories that the team has maintain access to.<br/> push - (Optional) The list of repositories that the team has push access to.<br/> triage - (Optional) The list of repositories that the team has triage access to.<br/> pull - (Optional) The list of repositories that the team has pull access to. | <pre>object({<br/> admin = list(string)<br/> maintain = list(string)<br/> push = list(string)<br/> triage = list(string)<br/> pull = list(string)<br/> })</pre> | <pre>{<br/> "admin": [],<br/> "maintain": [],<br/> "pull": [],<br/> "push": [],<br/> "triage": []<br/>}</pre> |    no    |
| <a name="input_team_repository_team_id"></a> [team_repository_team_id](#input_team_repository_team_id)                                              | (Required) The GitHub team id or the GitHub team slug to add the repositories to.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `number`                                                                                                                                                        | `null`                                                                                                        |    no    |

## Outputs

| Name                                                                                                                    | Description                                                                                                                                                                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <a name="output_team_id"></a> [team_id](#output_team_id)                                                                | The ID of the created team.                                                                                                                                                                                                                                                   |
| <a name="output_team_membership_memberships"></a> [team_membership_memberships](#output_team_membership_memberships)    | The list of team memberships.                                                                                                                                                                                                                                                 |
| <a name="output_team_node_id"></a> [team_node_id](#output_team_node_id)                                                 | The Node ID of the created team.                                                                                                                                                                                                                                              |
| <a name="output_team_repository_repositories"></a> [team_repository_repositories](#output_team_repository_repositories) | The list of team repositories.                                                                                                                                                                                                                                                |
| <a name="output_team_slug"></a> [team_slug](#output_team_slug)                                                          | The slug of the created team, which may or may not differ from `name`, depending on whether `name` contains "URL-unsafe" characters. Useful when referencing the team in [github_branch_protection](https://registry.terraform.io/docs/providers/github/r/branch_protection). |

<!-- END_TF_DOCS -->

## License

This work is licensed under MIT License. See [LICENSE](LICENSE) for full details.

## Authors

This module is maintained by the IbdaaiCloud team.
