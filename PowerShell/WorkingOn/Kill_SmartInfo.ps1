

$a = Get-QADuser -createdafter "December 1, 2010" | measure-object
[int]$b = $a 




$SMTPserver = "exchange.bytes.co.uk"
#$fileattachment = "c:\\boot.ini"
$from = "jamie.garrow-fisher@bytes.co.uk"
$to = "jamie.garrow-fisher@bytes.co.uk"
$subject = "PowerShell Test"
$emailbody = $a

$mailer = new-object Net.Mail.SMTPclient($SMTPserver)
$msg = new-object Net.Mail.MailMessage($from, $to, $subject, $emailbody)
#$attachment = new-object Net.Mail.Attachment($fileattachment)
$msg.attachments.add($attachment)
$mailer.send($msg) 