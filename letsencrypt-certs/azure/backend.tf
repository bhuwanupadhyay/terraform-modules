terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }
  required_version = ">= 0.14"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_dns_zone" "dns_zone" {
  name = var.root_domain
}

data "azurerm_storage_account" "staging_bucket" {
  name                = var.staging_bucket_name
  resource_group_name = var.resource_group_name
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "primary" {}