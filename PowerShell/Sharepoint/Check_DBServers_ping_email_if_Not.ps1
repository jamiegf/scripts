

$comps = "10.161.3.18", "10.161.3.16"




function Ping-Host {
        param (
        [string]$computer = "localhost"
               )
        $results = gwmi -Query "SELECT * FROM Win32_pingstatus WHERE Address = '$computer'"
        If ($results.statuscode -ne 0) {
           
           
            Write-Host "$computer is not pingable "
            #Email Body 
$emailBody = @"
Check the VPN on Reports PC 
$comp is not pingable

"@
                            $emailAddress = "alert@miomni.com"
                            $user = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
                            $port = "587"
			    $subject = "Connection to Report Servers down!"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $emailAddress
        } 
        }

        
foreach ($comp in $comps)
{
 
 Ping-Host $comp
 
 }