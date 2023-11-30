$today = Get-Date -format d.M.yyyy
$baks = "MVM-PRD1", "MVM-Inplay","MVM-Race", "failover"
foreach ($bak in $baks)
        {
        if (!(test-path e:\$bak\$today))
{#Email Body for Daily
$emailBody = @"
Backup for $bak not found!
Check back up on server

"@
                            $emailAddress = "alert@miomni.com"
                            $from = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			    $subject = "Alert! - backup for $bak not found"
                
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from 
                }
        }