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

# Terraform GitHub Team Wrapper

This repository is a wrapper for the [IbdaaiCloud/github-team](https://registry.terraform.io/modules/IbdaaiCloud/team/github/latest) Terraform module. It provides a way to deploy the module with a set of default values.

## Usage

The wrapper module provided here offers a convenient solution for managing multiple instances of the GitHub team module in scenarios where the native `for_each` feature introduced in `Terraform 0.13+` cannot be utilized, such as when working with Terragrunt.

This approach allows you to consolidate configurations into a single Terragrunt file, effectively managing multiple resources without duplicating `terragrunt.hcl` files for each instance of the module.

The wrapper is designed purely as a utility for orchestrating multiple modules and does not add any extra functionality beyond simplifying the configuration process.

### Example Usage with Terraform

```hcl
module "github_team" {
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

### Example Usage with Terragrunt

```hcl
terraform {
  source = "IbdaaiCloud/team/github//wrapper"
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

> [!WARNING]
> The `version` argument is omitted in the example's `source` block. It is strongly recommended to specify a version to ensure stability and avoid unexpected changes due to future updates. Use a version constraint like `version = "~> x.x.x"` in your project to lock the module to a compatible release.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13.0 |
| <a name="requirement_github"></a> [github](#requirement_github)          | >= 6.6.0  |
| <a name="requirement_null"></a> [null](#requirement_null)                | >= 3.2.3  |

## Providers

No providers.

## Modules

| Name                                                     | Source | Version |
| -------------------------------------------------------- | ------ | ------- |
| <a name="module_wrapper"></a> [wrapper](#module_wrapper) | ../    | n/a     |

## Resources

No resources.

## Inputs

| Name                                                      | Description                                                                      | Type  | Default | Required |
| --------------------------------------------------------- | -------------------------------------------------------------------------------- | ----- | ------- | :------: |
| <a name="input_defaults"></a> [defaults](#input_defaults) | Map of default values which will be used for each item.                          | `any` | `{}`    |    no    |
| <a name="input_items"></a> [items](#input_items)          | Maps of items to create a wrapper from. Values are passed through to the module. | `any` | `{}`    |    no    |

## Outputs

| Name                                                     | Description                  |
| -------------------------------------------------------- | ---------------------------- |
| <a name="output_wrapper"></a> [wrapper](#output_wrapper) | Map of outputs of a wrapper. |

<!-- END_TF_DOCS -->

## License

This work is licensed under MIT License. See [LICENSE](../LICENSE) for full details.

## Authors

This module is maintained by the IbdaaiCloud team.
