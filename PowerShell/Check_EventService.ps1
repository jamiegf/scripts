$service = "eventservice"
$a = Get-Service $service
$a.Status

if ($a.status -ne "running")
    {

$body = @" 
Service on $env:computername is down - $service


"@
#write-host $output

          
        


        
   
           $emailAddress = "alert@miomni.com"
                            $user = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
                            $port = "587"
			    $subject = "Service Alert"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $body -From $emailAddress
    }