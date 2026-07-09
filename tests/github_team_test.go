package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// TestModuleValidate runs `terraform init` + `terraform validate` against the
// root module. It needs no GitHub credentials, so it is safe to run in CI.
//
// ponytail: validate-only. To exercise real resource creation, add a
// terraform.InitAndApplyAndIdempotent against examples/github-team with a
// GITHUB_TOKEN + org set in the environment, and Destroy in a defer.
func TestModuleValidate(t *testing.T) {
	t.Parallel()

	terraform.InitAndValidate(t, &terraform.Options{
		TerraformDir: "..",
	})
}
