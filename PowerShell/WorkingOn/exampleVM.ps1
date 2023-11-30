#$a = read-host "Enter someting"
#write-host "you entered" + $a


$SMTPserver = "exchange.bytes.co.uk"
$fileattachment = "c:\test2.htm"
#$fileattachment = $fileattachment + "C:\usb.htm"
$from = "jamie.garrow-fisher@bytes.co.uk"
$to = "jamie.garrow-fisher@bytes.co.uk"
$subject = "Usage Report"
$emailbody = "test" 

$mailer = new-object Net.Mail.SMTPclient($SMTPserver)
$msg = new-object Net.Mail.MailMessage($from, $to, $subject, $emailbody)
$attachment = new-object Net.Mail.Attachment($fileattachment)
$msg.attachments.add($attachment)
$mailer.send($msg) 
