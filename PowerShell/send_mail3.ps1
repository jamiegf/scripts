    $SMTPserver = "mail.miomni.com"
    $from = "jamie.garrow-fisher@miomni.com"
    $to = "jamie.garrow-fisher@miomni.com"
    $bcc = "jamie.garrow-fisher@miomni.com"
    $subject = "Test"
    $emailbody = get-content 'c:\temp\eula.txt'
    $attachment = "c:\temp\Eula.txt"

    Send-MailMessage -To $to -from $from -bcc $bcc -smtpServer $SMTPServer -subject $subject -body $emailbody -attachments $attachment