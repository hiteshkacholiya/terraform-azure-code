output "resource_group_id" {
  description = "id of the resource group provisioned"
  value = "${module.rg-provision.resource_group_id}"
}
output "resource_group_name" {
  description = "name of the resource group provisioned"
  value = "${module.rg-provision.resource_group_name}"
}

