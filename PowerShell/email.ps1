$userid='jamie@jgf.cloud'
$creds=Get-Credential $userid
Send-MailMessage `
    -To 'jamie@miomni.com' `
    -Subject 'Test' `
    -Body 'Test' `
    -UseSsl `
    -Port 587 `
    -SmtpServer 'smtp.office365.com' `
    -From $userid `
    -Credential $creds