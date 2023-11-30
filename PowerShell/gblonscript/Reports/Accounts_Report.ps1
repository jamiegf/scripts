
Add-Pssnapin quest.activeroles.admanagement


$filelocked = "C:\scripts\outfile\locked.htm"
$filepassworddue = "C:\scripts\outfile\passworddue.htm"

$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"

$ou = "ou=EU Users,dc=eu,dc=above,dc=net"


$locked = Get-QADUser -searchroot $ou -Locked
#$locked1 = @($locked).count

$passworddue = get-qaduser -searchroot $ou -passwordnotchangedfor 38 | Sort-Object passwordstatus 


#titles of htms
$b= "<H2>Users with password set to 'Never Expire' </H2>"
$b= $b + "<H3>Total = " + $noexpire1 + "</H3>"

$bb = "<H2>Locked Accounts </H2>"
#$bb= $bb + "<H3>Total = " + $locked1 + "</H3>"

$cc = "<H2>Password Expiries </H2>"
#$bb= $bb + "<H3>Total = " + $locked1 + "</H3>"


$locked |convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $bb | out-file $filelocked

#$locked | out-file $filelocked

$passworddue | convertto-html -Property Name, LastLogonTimeStamp, PasswordStatus -head $a -body $cc | out-file $filepassworddue



$SMTPserver = "webmail.above.net"
#$fileattachment = $filelocked , $filepassworddue
$from = "ukit@above.net"
$to = "ukit@above.net"
#$to = "jgarrow-fisher@above.net"
$subject = "Daily AD Users Report"
if ($locked -eq $null)
	   {$fileattachment = $filepassworddue 
	   $emailbody = "Report attached `n *No locked Accounts*"
       }
		else
	{$fileattachment = $filelocked , $filepassworddue
	$emailbody = "Reports attached"}
	

Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody





