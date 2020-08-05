output "resource_group_id" {
  description = "id of the resource group provisioned"
  value = "${azurerm_resource_group.rg.id}"
}
output "resource_group_name" {
  description = "name of the resource group provisioned"
  value = "${azurerm_resource_group.rg.name}"
}

