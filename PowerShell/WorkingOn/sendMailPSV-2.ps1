$SMTPserver = "exchange.bytes.co.uk"
$fileattachment = "c:\test2.htm", "c:\usb.htm"
$from = "jamie.garrow-fisher@bytes.co.uk"
$to = "jamie.garrow-fisher@bytes.co.uk"
$subject = "Usage Report"
$emailbody = "test" 

Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody
