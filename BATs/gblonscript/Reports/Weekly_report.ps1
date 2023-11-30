
Add-Pssnapin quest.activeroles.admanagement
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

$filenoexpire = "c:\scripts\outfile\noexpire.htm"
$filenewaccounts = "C:\scripts\outfile\newaccounts.htm"
$filemailboxes = "C:\scripts\outfile\mailboxes.htm"

$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"

$ou = "ou=EU Users,dc=eu,dc=above,dc=net"

$noexpire = Get-QADUser -searchroot $ou -PasswordNeverExpires | Sort-Object
$noexpire1 = @($noexpire).count
$date = (Get-Date).adddays(-30)
$newaccounts = get-qaduser -createdafter $date
$newaccounts1 = @($newaccounts).count

$mailboxes = get-mailbox -server gblonexmb01 | get-mailboxstatistics | sort totalitemsize -desc | select-object DisplayName, @{label="MailboxSize(MB)";expression={$_.TotalItemSize.Value.ToMB()}},ItemCount




#titles of htms
$b= "<H2>Users with password set to 'Never Expire' </H2>"
$b= $b + "<H3>Total = " + $noexpire1 + "</H3>"

$bb = "<H2>New accounts created in last 30 days</H2>"
$bb= $bb + "<H3>Total = " + $newaccounts1 + "</H3>"

$cc = "<H2>Mailboxes</H2>"

#create outfiles
$noexpire | convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $b | out-file $filenoexpire

$newaccounts |ConvertTo-Html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -Body $bb | Out-File $filenewaccounts

$mailboxes | ConvertTo-Html -head $a -body $cc | Out-File $filemailboxes
$date = ( get-date ).ToString('yyyyMMdd')
Copy-Item "c:\scripts\outfile\mailboxes.htm" "C:\Scripts\Reports\Mailbox_Archive\$date-mailboxes.htm"

#email out
$SMTPserver = "webmail.above.net"
$fileattachment = $filenoexpire , $filenewaccounts , $filemailboxes
$from = "ukit@above.net"
$to = "ukit@above.net"
#$to = "euit@above.net"
$subject = "Weekly AD Users Report"
#$emailbody = "Reports attached"

$emailbody = @"
Reports attached

Archived mailbox reports can be found at :
\\gblonscript01\c$\Scripts\Reports\Mailbox_archive

"@



Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody


