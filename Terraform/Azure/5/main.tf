# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}
#
#### begin modules

module "vnet" {
  source = "./modules/rg"
  resource_group = "yo_mofo"
  }