provider "azurerm" {
  version = ">=2.4.0"
  features {}
}

locals {
    // 1. We are doing a replace on spaces in resource group name since Terraform is not supporting that currently
    // 2. We are also truncating the rg name if it is greater than 64 characters since that is the max that Azure supports
    rg_name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
    get_secret_api = "https://your-apim-hostname.azure-api.net/GetKeyVaultSecret?SecretName="
    ocp_subscription_key  = "your-api-subscription-key"
}

#Fetch secrets from Azure Key Vault using APIs
data "http" "GetKeyVaultSecret" {
  count = length(var.secret_names)
  
  //Below block fetches the key vault secrets for all comma separated keys specified in variables
  url = "${local.get_secret_api}${element(var.secret_names,count.index)}"
  
  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Ocp-Apim-Subscription-Key = local.ocp_subscription_key
  }
}

data "http" "GetSubscriptionKey" {
  url = "${local.get_secret_api}${replace(var.subscription_name,"_","-")}"
  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Ocp-Apim-Subscription-Key = local.ocp_subscription_key
  }
}

#Invoke the custom module for provisioning of resource group
#Passing all the secrets fetched from key vault using custom API
#These values will be used to register the AzureRM provider
module "rg-provision" {
  source = ".//Modules/rg-provision"
  subscription_id   = jsondecode(data.http.GetSubscriptionKey.body)
  tenant_id       = jsondecode(data.http.GetKeyVaultSecret[0].body)
  client_id      = jsondecode(data.http.GetKeyVaultSecret[1].body)
  client_secret   = jsondecode(data.http.GetKeyVaultSecret[2].body)
  resource_location = var.resource_location
  instance_type = var.instance_type
}