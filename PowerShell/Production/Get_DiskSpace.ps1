
$comps = Get-Content "C:\Scripts\Servers.txt"
 $outputcombined = ""
      foreach ($comp in $comps)
      {
        $drives=Get-WmiObject Win32_LogicalDisk -ComputerName $comp -Filter "DriveType = 3" 

        foreach ($drive in $drives){
                   
            $drivename=$drive.DeviceID
            $freespace=[int]($drive.FreeSpace/1GB)
            $totalspace=[int]($drive.Size/1GB)
            $usedspace=$totalspace - $freespace

$output = @"
Drive : $comp\$drivename 
FreeSpace  : $freespace GB


"@
#write-host $output
$outputcombined = $outputcombined + $output
        }   
        }


        write-host $outputcombined
   
                            $emailAddress = "notifications_WV@miomni.com"
                            $user = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
                            $port = "587"
			    $subject = "WV Disk Space"
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $outputcombined -From $emailAddress
       

      