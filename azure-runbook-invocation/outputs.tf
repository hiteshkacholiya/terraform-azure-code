output "Remarks" {
    value = "Your runbook has been invoked successfully"
    depends_on = [
        null_resource.invoke_azure_runbook
    ]
}