# Define Parameters to be passed to script from Terraform via Local-Exec
param (
    [string]$Param1,
    [string]$Param2
)

#Create a request body object for webhook
$body = @{
 Attribute1 = $Param1
 Attribute2 = $Param2
}

#Convert above object into Json
$requestBody = $body | ConvertTo-Json
#$uri = "Your_Runbook_Webhook_Uri which you copied during webhook creation"
$uri = "https://41d883d4-c345-47eb-83e3-1a972cb7e224.webhook.we.azure-automation.net/webhooks?token=5CE5OBLQBm4s%2bFhnHEeH9BcXELKhatz3SETvlrb8qQY%3d"

#Invoke the webhook using Webhook Uri
$response = Invoke-WebRequest -Method Post -Uri $uri -Body $requestBody

if($response.StatusCode -eq "202" -and $response.StatusDescription -eq "Accepted")
{
    Write-Host "Your webhook invocation is completed."
}
else
{
    Write-Host "Your webhook invocation has failed."
}