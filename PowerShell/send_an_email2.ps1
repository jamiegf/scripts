#Email users whos password are about to expire

    $SMTPserver = "webmail.above.net"
    $from = "ben.mccardle@blueyonder.co.uk"
    $to = "ben.mccardle@blueyonder.co.uk"
    $bcc = "jamie.garrow-fisher@above.net"
    $subject = "You are a PRIZE WINNER!"
    $emailbody = "pls respond with your bank account details"
    

    Send-MailMessage -To $to -from $from -bcc $bcc -smtpServer $SMTPServer -subject $subject -body $emailbody
    