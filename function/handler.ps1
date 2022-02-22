param (
        $Input
)

$Json = ($Input | ConvertFrom-Json)

$Message = $Json.message
$EmailMessage = @"
<html><body>
$Message
</body></html>
"@

$MailAPI = "$ENV:ENV_MAILGUN_API_TOKEN"
$MailURL = "$ENV:ENV_MAILGUN_URL"
$MailFrom = "$ENV:ENV_MAILGUN_FROM"

$MailTo = $Json.to

$MailSubject = "Notification"
$MailBody = $EmailMessage

$Params = @{
  "URI"            = $MailURL
  "Form"           = @{
    "from"    = $MailFrom
    "to"      = $MailTo
    "subject" = $MailSubject
    "html"    = $MailBody
  }
  "Authentication" = 'Basic'
  "Credential"     = (New-Object System.Management.Automation.PSCredential ("api", ($MailAPI | ConvertTo-SecureString -AsPlainText)))
  "Method"         = 'POST'
}

Invoke-RestMethod @Params
