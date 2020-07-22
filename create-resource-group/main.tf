provider "azurerm" {
  version = ">=2.4.0"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  //For Service Principle based authentication
  client_id       = var.client_id   
  client_secret   = var.client_secret
  //use_msi = true // set to true for using System Assigned Managed Identities
  features {}
}

locals {
    // 1. We are doing a replace on spaces in resource group name since Terraform is not supporting that currently
    // 2. We are also truncating the rg name if it is greater than 64 characters since that is the max that Azure supports
    rg_name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}


resource "azurerm_resource_group" "rg"{
  name      = local.rg_name
  location  = var.resource_location
  tags = {
    InstanceType  = var.instance_type
  }
}