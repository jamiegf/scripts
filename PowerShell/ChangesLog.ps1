$yesterday = ((get-date).adddays(-1)).tostring('dd/MM/yyyy') 

$event = Get-winEvent -filterhashtable @{logname='security';id=4663; starttime=$yesterday} | ?{$_.message -match "WriteData" -or $_.message -match "Delete"  -or $_.message -match "AppendData"}


$emailBody = $event | fl message, timecreated | out-string 

                            $emailAddress = "alert@miomni.com"
                            $from = "Notifications_WV@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"

                            $subject = "Changes on WWWRoot:  $env:computername"
            
 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from