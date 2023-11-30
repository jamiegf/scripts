$emailbody = "test"
                           $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                            $password = "777RedHound321"
                           # $to = @("logs@miomni.com", "dgtemba@yahoo.co.uk")
                            $to = @("jamie.garrow-fisher@miomni.com")
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Live Logs"
                            
                           
#"$timeStamp sending email1" >> $ProgLog #debug
 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from