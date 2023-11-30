$timer = 60
$leagueSummaries = "C:\inetpub\wwwroot\Station-Inplay-6-0\LeagueSummaries"
$newestFile = Get-childitem -Path $leagueSummaries\ -recurse | Sort-Object -Property LastwriteTime | select-object -last 1
$path = $newestFile.Fullname
 # Get LastWriteTime of the file
$LastWrite = (get-childitem $path).LastWriteTime
# Check if the LastWriteTime is older than X minutes. if it is; send an email
    if ($LastWrite -lt (get-date).AddMinutes(-$timer) ) { 
            write-host "$path is older than $timer minutes. Last write was $LastWrite"
          $emailBody = 
@"
Inplay - League Summaries 
has not updated in the last $timer minutes !!!
Last write time = $LastWrite
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
        
}