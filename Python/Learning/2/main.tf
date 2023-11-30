terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.69.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "f644ce8c-6f31-4671-b02e-08f7945432e0"   # get from subscription page
  client_id = "3e8ad3a4-e320-4f1d-94f1-74f829adb654"   # get from app registration
  client_secret = "w8q8Q~g5h-gdeh4Rtlit9fso46MbUNnTC4GMnaXS" # create a secret key with "Certificates and secrets"
  tenant_id = "e56afa3f-40c5-4668-be5c-33700b70cd2d"  # get from app registration
  features { 
  }
  resource "azurerm_resource_group" "hellow_orld_rg" {
  name     = "hello_world_rg"
  location = "West Europe"
}

}
