output "ResourceGroupId" {
  description = "id of the resource group provisioned"
  value = "${azurerm_resource_group.rg.id}"
}
output "ResourceGroupName" {
  description = "name of the resource group provisioned"
  value = "${azurerm_resource_group.rg.name}"
}

