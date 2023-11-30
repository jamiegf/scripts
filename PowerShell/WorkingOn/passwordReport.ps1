
Add-Pssnapin quest.activeroles.admanagement
$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"
$noexpire = Get-QADUser -PasswordNeverExpires | Sort-Object
$noexpire1 = @($noexpire).count
$locked = Get-QADUser -Locked | Sort-Object
$locked1 = @($locked).count


$b= "<H2>Users with password set to 'Never Expire' </H2>"
$b= $b + "<H3>Total = " + $noexpire1 + "</H3>"

$bb = "<H2>Locked Accounts </H2>"
$bb= $bb + "<H3>Total = " + $locked1 + "</H3>"


$noexpire | convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $b | out-file c:\scripts\noexpire.htm

$locked |convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $bb | out-file c:\scripts\locked.htm




$SMTPserver = "exchange.bytes.co.uk"
$fileattachment = "c:\scripts\locked.htm", "c:\scripts\noexpire.htm"
$from = "Internal.Helpdesk@bytes.co.uk"
$to = "jamie.garrow-fisher@bytes.co.uk"
$subject = "Password Report"
$emailbody = @"
Accounts with password set to 'Never Expire' = $noexpire1

 Locked accounts = $locked1


"@



Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody











