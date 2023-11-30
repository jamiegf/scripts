#Auto email using an office365 account
$emailAddress = "alerts@miomni.com"
$password = "777RedHound321"
$recipient = "jamie.garrow-fisher@miomni.com"
#$cc = "jamie@miomni.com"
$title = "Test Notification"
$body = @"
Reports attached

Archived mailbox reports can be found at :
\\gblonscript01\c$\Scripts\Reports\Mailbox_archive

"@


$smtpServer = "smtp.office365.com"
$port = "587"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)

Send-MailMessage -To $recipient `
-SmtpServer $smtpServer `
-Credential $mycreds `
-UseSsl $title `
-Port $port `
-Body $body `
-From $emailAddress `
