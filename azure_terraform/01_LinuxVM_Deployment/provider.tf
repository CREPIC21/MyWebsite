/*

Dcumentation:

1. azurerm - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

*/

# Defining the provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

provider "azurerm" {
  subscription_id = file("../keys/subscription_id")
  tenant_id       = file("../keys/tenant_id")
  client_id       = file("../keys/client_id")
  client_secret   = file("../keys/client_secret")
  features {

  }
}
