#Checks pleeapp files to see if inventories are being updated. If not, an email is sent. 


$pleejsons = Get-Content  "C:\inetpub\wwwroot\PleeJsons.txt"
$timer = -15 #last write time time 


foreach ($pleejson in $pleejsons)
    
    {
        $start = Get-Date 
        $file = Get-Item $pleejson
        $end = $file.lastwritetime
        $timediff = ($End – $Start).minutes
        
        If ($timediff -le $timer)
        
        {$emailBody = 
@"
$pleejson
has not updated in the last $timer minutes !!!
$env:COMPUTERNAME
"@



    $emailAddress = "alert@miomni.com"
                                $password = "777RedHound321"
                                $to = "sysadmin@miomni.com"
                                $smtpServer = "smtp.office365.com"
                                $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                                $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                                $port = "587"
			                    $subject = "Inventory Alert! "
                            
                            
                           
               Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $emailAddress
             }}