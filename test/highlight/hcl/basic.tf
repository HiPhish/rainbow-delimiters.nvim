terraform {
  required_providers {
    provider1 = {
      source  = "provider1"
      version = "0.1.3"
    }
  }
}

data "terraform_remote_state" "test_remotestate" {
  backend = "test"

  config = {
    storage_account_name = "abc"
    container_name       = "terraform-state"
    key                  = "prod.terraform.tfstate"
  }
}

resource "provider_role_grants" "admins_role_grants" {
  provider  = provider.security_admin
  role_name = provider_role.admins_role.name
  users     = [provider_user.user1.name]
  roles     = [provider_role.role2.name]
}

resource "provider_grant" "usage_grants" {
  for_each  = toset(["USAGE", "TEST"])
  privilege = each.key
  roles     = [provider_role.role2.name]
}

# vim:ft=hcl
