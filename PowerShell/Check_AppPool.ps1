# Load IIS module:
Import-Module WebAdministration
 
# SET AppPool Name
$appPoolName = "Miomni-Inplay-NV-STG"
If((get-WebAppPoolState -name $appPoolName).Value -ne "Started")

       {        
                $emailBody = 
@"
$appPoolName appPool
is not running on
$env:COMPUTERNAME
"@
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "stg-alerts@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "AppPool Alert"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $emailAddress
        
         }
       
 