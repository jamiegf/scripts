
Add-Pssnapin quest.activeroles.admanagement

$filenoexpire = "c:\scripts\outfile\noexpire.htm"
$filenewaccounts = "C:\scripts\outfile\newaccounts.htm"

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




#titles of htms
$b= "<H2>Users with password set to 'Never Expire' </H2>"
$b= $b + "<H3>Total = " + $noexpire1 + "</H3>"

$bb = "<H2>New accounts created in last 30 days</H2>"
$bb= $bb + "<H3>Total = " + $newaccounts1 + "</H3>"




$noexpire | convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $b | out-file $filenoexpire

$newaccounts |ConvertTo-Html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -Body $bb | Out-File $filenewaccounts



$SMTPserver = "webmail.above.net"
$fileattachment = $filenoexpire , $filenewaccounts
$from = "ukit@above.net"
$to = "ukit@above.net"
#$to = "jgarrow-fisher@above.net"
$subject = "Weekly AD Users Report"
$emailbody = "Reports attached"

#$emailbody = @"
#Accounts with password set to 'Never Expire' = $noexpire1
#
# Locked accounts = $locked1
#
#
#"@



Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody


