#Define Local Variables
locals {
# Replacing blank spaces from variable value and storing it in local variable called “variable2”
variable2 = replace(var.variable2, " ", "")
}

#Invocation of Azure Runbook via Local-Exec 
resource "null_resource" "invoke_azure_runbook" {
   provisioner "local-exec" {
   command = ".\\Invocation-Script.ps1 -Param1 '${var.variable1}' -Param2 '${local.variable2}'"
   interpreter = ["PowerShell","-Command"]
   }          
  }
