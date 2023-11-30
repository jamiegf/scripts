
Add-Pssnapin quest.activeroles.admanagement
$days = 200
$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"
$c = get-qaduser -NotLoggedOnFor $days
$d = $c.count
$b = "<H2>Users that have not logged in for the last " + $days + " days</H2>"
$b= $b + "<H3>Total = " + $d + "</H3>"





Get-QADUser -NotLoggedOnFor $days | Sort-Object name | 
convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $b | out-file c:\test2.htm
# Get-Service | Select-Object Status, Name, DisplayName | ConvertTo-HTML -head $a -body $b | Out-File C:\Scripts\Test.htm

#Invoke-Expression C:\Test2.htm

$SMTPserver = "exchange.bytes.co.uk"
$fileattachment = "c:\test2.htm"
$from = "jamie.garrow-fisher@bytes.co.uk"
$to = "jamie.garrow-fisher@bytes.co.uk"
$subject = "Usage Report"
$emailbody = "Report is attached"

$mailer = new-object Net.Mail.SMTPclient($SMTPserver)
$msg = new-object Net.Mail.MailMessage($from, $to, $subject, $emailbody)
$attachment = new-object Net.Mail.Attachment($fileattachment)
$msg.attachments.add($attachment)
$mailer.send($msg) 










