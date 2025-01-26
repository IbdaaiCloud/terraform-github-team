#---------------------------------------------------
# GitHub Repository
#---------------------------------------------------
resource "github_repository" "devops_repo" {
  name        = "devops-repo"
  description = "This is the DevOps repository."
}

resource "github_repository" "qa_repo" {
  name        = "qa-repo"
  description = "This is the QA repository."
}

resource "github_repository" "py_dev_repo" {
  name        = "python-dev-repo"
  description = "This is the Python Developers repository."
}

resource "github_repository" "js_dev_repo" {
  name        = "javascript-dev-repo"
  description = "This is the JavaScript Developers repository."
}

resource "github_repository" "infra_repo" {
  name        = "infra-repo"
  description = "This is the Infrastructure repository."
}

resource "github_repository" "security_repo" {
  name        = "security-repo"
  description = "This is the Security repository."
}

#---------------------------------------------------
# Module Team Configuration
#---------------------------------------------------
module "team_configuration_wrapper" {
  source = "IbdaaiCloud/team/github//wrapper"
  # version = "x.y.z" # Use the latest version from the Terraform Registry

  defaults = {
    #---------------------------------------------------
    # GitHub Team
    #---------------------------------------------------
    enable_team_creation           = true
    team_privacy                   = "secret"
    team_parent_team_id            = null
    team_ldap_dn                   = null
    team_create_default_maintainer = false

    #---------------------------------------------------
    # GitHub Team Membership
    #---------------------------------------------------
    enable_team_memberships_creation = true

    #---------------------------------------------------
    # GitHub Team Repository
    #---------------------------------------------------
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
    #---------------------------------------------------
    # DevOps Team Configuration
    #---------------------------------------------------
    devops = {
      #---------------------------------------------------
      # GitHub Team
      #---------------------------------------------------
      team_name        = "DevOps"
      team_description = "The DevOps team"

      #---------------------------------------------------
      # GitHub Team Membership
      #---------------------------------------------------
      team_membership_maintainers = [
        "devops_maintainer1",
        "devops_maintainer2",
      ]
      team_membership_members = [
        "devops_member1",
        "devops_member2",
        "devops_member3",
      ]

      #---------------------------------------------------
      # GitHub Team Repository
      #---------------------------------------------------
      team_repository_permissions = {
        admin = [
          github_repository.devops_repo.name,
          github_repository.infra_repo.name,
        ]
        maintain = [
          github_repository.py_dev_repo.name,
          github_repository.security_repo.name,
        ]
        push = [
          github_repository.js_dev_repo.name,
        ]
        pull = [
          github_repository.qa_repo.name,
        ]
      }
    }

    #---------------------------------------------------
    # QA Team Configuration
    #---------------------------------------------------
    qa = {
      #---------------------------------------------------
      # GitHub Team
      #---------------------------------------------------
      team_name        = "QA"
      team_description = "The QA team"

      #---------------------------------------------------
      # GitHub Team Membership
      #---------------------------------------------------
      team_membership_maintainers = [
        "qa_maintainer1",
        "qa_maintainer2",
      ]
      team_membership_members = [
        "qa_member1",
        "qa_member2",
        "qa_member3",
      ]

      #---------------------------------------------------
      # GitHub Team Repository
      #---------------------------------------------------
      team_repository_permissions = {
        admin = [
          github_repository.qa_repo.name,
        ]
        maintain = [
          github_repository.py_dev_repo.name,
        ]
        push = [
          github_repository.js_dev_repo.name,
        ]
        pull = [
          github_repository.devops_repo.name,
          github_repository.infra_repo.name,
        ]
      }
    }

    #---------------------------------------------------
    # Python Developers Team Configuration
    #---------------------------------------------------
    python_dev = {
      #---------------------------------------------------
      # GitHub Team
      #---------------------------------------------------
      team_name        = "Python Developers"
      team_description = "The Python Developers team"

      #---------------------------------------------------
      # GitHub Team Membership
      #---------------------------------------------------
      team_membership_maintainers = [
        "python_dev_maintainer1",
        "python_dev_maintainer2",
      ]
      team_membership_members = [
        "python_dev_member1",
        "python_dev_member2",
        "python_dev_member3",
      ]

      #---------------------------------------------------
      # GitHub Team Repository
      #---------------------------------------------------
      team_repository_permissions = {
        admin = [
          github_repository.py_dev_repo.name,
        ]
        maintain = [
          github_repository.qa_repo.name,
        ]
        push = [
          github_repository.js_dev_repo.name,
        ]
        pull = [
          github_repository.devops_repo.name,
          github_repository.infra_repo.name,
        ]
      }
    }

    #---------------------------------------------------
    # JavaScript Developers Team Configuration
    #---------------------------------------------------
    javascript_dev = {
      #---------------------------------------------------
      # GitHub Team
      #---------------------------------------------------
      team_name        = "JavaScript Developers"
      team_description = "The JavaScript Developers team"

      #---------------------------------------------------
      # GitHub Team Membership
      #---------------------------------------------------
      team_membership_maintainers = [
        "javascript_dev_maintainer1",
        "javascript_dev_maintainer2",
      ]
      team_membership_members = [
        "javascript_dev_member1",
        "javascript_dev_member2",
        "javascript_dev_member3",
      ]

      #---------------------------------------------------
      # GitHub Team Repository
      #---------------------------------------------------
      team_repository_permissions = {
        admin = [
          github_repository.js_dev_repo.name,
        ]
        maintain = [
          github_repository.qa_repo.name,
        ]
        push = [
          github_repository.py_dev_repo.name,
        ]
        pull = [
          github_repository.devops_repo.name,
          github_repository.infra_repo.name,
        ]
      }
    }
  }
}
