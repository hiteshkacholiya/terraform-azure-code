variable subscription_id {
  type = string
  description = "The id of the resource group in which the resources will be created"
}

variable tenant_id{
  type = string
  description = "The tenant id of the application registration to be used"    
}

variable client_id{
  type = string
  description = "The client id of the application registration to be used"    
}

variable client_secret{
  type = string
  description = "The client secret of the application registration to be used"    
}

variable resource_group_name{
  type = string
  default = "testrg"
  description = "The name of resource group required to be provisioned"
}

variable resource_location {
    type = string
    description = "The location to deploy Azure resources requested"
}

variable instance_type {
    type = string
    description = "Instance Type Tag Value"
}