param
(
    [Parameter (Mandatory = $true)]
    [object] $WebhookData
)

try 
{
# If runbook was called from Webhook, WebhookData will not be null.
if ($WebhookData)
{
    #Retrieve data from Webhook request body
    $inputs = (ConvertFrom-Json -InputObject $WebhookData.RequestBody)

    #Fetch values of parameters passed to webhook in form of request body
    $Attribute1=$inputs.Attribute1
    $Attribute2=$inputs.Attribute2
    
    Write-Output "=========================================================="
    
    Write-Output "Value of First Parameter - " $Attribute1
    Write-Output "Value of Second Parameter - " $Attribute2
    
    Write-Output "=========================================================="
    
    }
}
catch 
{
Write-Output $_.Exception.Message
Write-Error "This runbook is meant to be started from webhook only." -ErrorAction Stop
}
