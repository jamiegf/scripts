#read-host -assecurestring | convertfrom-securestring | out-file d:\cred.txt

$username = "jamie@jgf.cloud"
$password = Get-Content 'C:\mysecurestring.txt' | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password


#$password = get-content d:\cred.txt | convertto-securestring

#$credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist "jamie@jgf.cloud",$password

$userid='jamie@jgf.cloud'
Send-MailMessage `
    -To 'jamie@miomni.com' `
    -Subject 'Test' `
    -Body 'Test' `
    -UseSsl `
    -Port 587 `
    -SmtpServer 'smtp.office365.com' `
    -From $userid `
    -Credential $creds
    exit


