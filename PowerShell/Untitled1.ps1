#script will test site. If it doesnt return http 200, an email will be sent and the site will be restarted
#

import-module webadministration
$websiteURL = "http://www.miomni.com"
$websiteName = "Miomni"
$call = "cleared"


$call = invoke-webrequest $websiteURL -DisableKeepAlive -UseBasicParsing -Method head


if ($call.statuscode -ne "200")
    {



           $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			    $subject = "Miomni Website is down"
			    $emailbody = "Miomni Website is down"
                            $from = "alert@miomni.com"
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from  

#restart website
Get-Website | where {$_.name -eq $websiteName} | stop-website
write-host "stopping $websitename"
iisreset

Get-Website | where {$_.name -eq $websiteName} | start-website

    }