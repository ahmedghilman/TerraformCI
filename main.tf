terraform {
  required_version = "~> 1.5.6"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = ">=3.43.0"
    }

  }
  #Terraform cloud code block
  cloud {
    organization = "Terraform_CI"

    workspaces {
      name = "TerraformCI"
    }
  }

}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = "811-4c096141-provide-continuous-delivery-with-gith"
  location = "westus"
}
resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}