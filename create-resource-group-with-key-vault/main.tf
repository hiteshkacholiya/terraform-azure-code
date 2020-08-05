//We are getting the details subscription id, tenant id, client id and client secret dynamically to the Azure provider.
//The values are fetched with the custom Key Vault API invokation and then parsing is done using jsoncode.
provider "azurerm" {
  version = ">=2.4.0"
  subscription_id = jsondecode(data.http.GetSubscriptionId.body)
  tenant_id       = jsondecode(data.http.GetKeyVaultSecrets[0].body)
  //Use this only for Service Principle based authentication
  client_id       = jsondecode(data.http.GetKeyVaultSecrets[1].body)   
  client_secret   = jsondecode(data.http.GetKeyVaultSecrets[2].body)
  //use_msi = true // uncomment and set to true for using System Assigned Managed Identities
  features {}
}

locals {
    // 1. We are doing a replace on spaces in resource group name since Terraform is not supporting that currently
    // 2. We are also truncating the rg name if it is greater than 64 characters since that is the max that Azure supports
    rg_name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
    get_secret_api = "https://your-apim-domain-name.azure-api.net/GetKeyVaultSecrets?SecretName="
    ocp_subscription_key  = "your-apim-subscription-key"
}

#Fetch secrets from Azure Key Vault using custom API
data "http" "GetKeyVaultSecrets" {
  count = length(var.secret_names)
  
  //Below block fetches the key vault secrets for all comma separated keys specified in variables
  url = "${local.get_secret_api}${element(var.secret_names,count.index)}"
  
  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Ocp-Apim-Subscription-Key = local.ocp_subscription_key
  }
}

#Fetch the subscription Id from Azure Key Vault using custom API
data "http" "GetSubscriptionId" {
  url = "${local.get_secret_api}${replace(var.subscription_name,"_","-")}"
  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Ocp-Apim-Subscription-Key = local.ocp_subscription_key
  }
}

#Provision Resource Group
resource "azurerm_resource_group" "rg"{
  name      = local.rg_name
  location  = var.resource_location
  tags = {
    InstanceType  = var.instance_type
  }
}