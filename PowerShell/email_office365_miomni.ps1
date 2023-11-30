#Email Body for Daily
$emailBody = @"
Sample
Body
Text 

"@
                            $emailAddress = "payment_failure@miomni.com"
                            $user = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "cristi.radulescu@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
                            $port = "587"
			    $subject = "Testing Testing 1,2,3"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $emailAddress