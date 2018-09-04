provider "vault" {
  version = "~> 1.1"
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  # address = "https://vault.example.net:8200"
}

data "vault_generic_secret" "aws" {
  path = "secret/aws"
}

provider "aws" {
  version = "~> 1.34"
  access_key = "${data.vault_generic_secret.aws.data["access_key"]}"
  secret_key = "${data.vault_generic_secret.aws.data["secret_key"]}"
  region = "us-east-1"
}

# Configure the Consul provider
provider "consul" {
  version = "~> 2.1"
  # address    = "http://localhost:8500"
  # datacenter = "dc1"
}
