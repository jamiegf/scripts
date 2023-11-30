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
  locals {
    main_subnet = "tf_main_subnet"
    virtual_network = var.virtual_network
  }

#### begin modules


module "vnet" {
  source = "./modules/vnet"
  resource_group = "tf_ResourceGroup" #update this for new rg name
  }
  module "vm" {
  source = "./modules/vm"
  vm = "win-srv2" #update this for new vm name
  main_subnet = local.main_subnet
  virtual_network = local.virtual_network
  }

    module "vmss" {
  source = "./modules/scaleset"
  #vm = "win-srv2" #update this for new vm name
  main_subnet = local.main_subnet
  }

