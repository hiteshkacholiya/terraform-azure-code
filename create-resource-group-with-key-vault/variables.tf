variable resource_group_name{
  type = string
  default = "testrg"
  description = "The name of resource group required to be provisioned"
}

variable secret_names {
    type = list(string)
    description = "List of all secret names for which values are to be fetched from key vault.."
    default = ["SHS-TenantID","sp-sa-CloudOpsAutomationMPCD-Dev-01-AppId","sp-sa-CloudOpsAutomationMPCD-Dev-01-Secret"]
}

variable subscription_name {
  type = string
  default = "your-subscription-name"
  description = "Provide the subscriptinon name to fetch subscription id from key vault"
}

variable resource_location {
    type = string
    description = "The location to deploy Azure resources requested"
}

#region: Tags to be used for Resource Group Creation

variable instance_type {
    type = string
    description = "Instance Type Tag Value"
}