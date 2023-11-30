                $fromAddress = "noreply@mipools.com"
                $emailAddress = "helpdesk@mipools.com"
                $password = "CageTraffic765"
                $to = "jamie@miomni.com"
                $smtpServer = "smtp.office365.com"
                $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                $port = "587"
			    $subject = "Testing"
                $emailbody = "whatever"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $fromAddress
        