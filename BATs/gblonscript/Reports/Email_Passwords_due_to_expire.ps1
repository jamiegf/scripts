#Email users whos password are about to expire

Add-Pssnapin quest.activeroles.admanagement
$ou = "ou=EU Users,dc=eu,dc=above,dc=net"
$a = get-qaduser -searchroot $ou -passwordnotchangedfor 38 
$a | % { 

    $days = $_.passwordstatus
    if ($days -ne "Expired")
    {
    $SMTPserver = "webmail.above.net"
    $from = "ukit@above.net"
    $to = $_.email
    $bcc = "jgarrow-fisher@above.net"
    $subject = "Your Windows password is about to expire!"
    $emailbody = " $days 
    
 Please change your password via Ctrl + Alt + Del
 
 
 
 
 Regards
 
 EU IT "
    Send-MailMessage -To $to -from $from -bcc $bcc -smtpServer $SMTPServer -subject $subject -body $emailbody
     }                                   
     }
