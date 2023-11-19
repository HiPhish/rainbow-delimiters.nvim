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

resource "example" "binary_expressions" {
  cond1 = (0*1) ? 1 : "foobar"
  bin1  = ((!(1)+2)%3)*4
}

resource "example" "for_expressions" {
  for1 = { for i, v in ["a", "a", "b"] : v => i... }
  for2 = [ for k, v in x : "${k}-${v}" ]
}

variable "timestamp" {
  type = string

  validation {
    # formatdate fails if the second argument is not a valid timestamp
    condition     = can(formatdate("", var.timestamp))
    error_message = "Hello, %{ if var.name != "" }${var.name}%{ else }unnamed%{ endif }!"
  }
}

block {
  sample = <<-EOT
  %{ for ip in aws_instance.example[*].private_ip }
  server ${ip}
  %{ endfor }
  EOT
}

resource "terraform_data" "cluster" {
  # Replacement of any instance of the cluster requires re-provisioning
  triggers_replace = aws_instance.cluster.[*].id

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.cluster.[0].public_ip
  }
}

# vim:ft=hcl
