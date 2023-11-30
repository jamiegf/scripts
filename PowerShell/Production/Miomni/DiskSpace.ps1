$warningThreshold = 4
 # adjust for number of GBs to warn at. 
$comps = "prd-logs"
$subject = "Disk Space"
$outputcombined = ""
$subjectWarning =  ""
$message = ""

      foreach ($comp in $comps)
      {
      $subjectWarnings = ""
        $drives=Get-WmiObject Win32_LogicalDisk -ComputerName $comp -Filter "DriveType = 3" 
        #$i = 0
        foreach ($drive in $drives){
        #$i++

                   
            $drivename=$drive.DeviceID
            $freespace=[int]($drive.FreeSpace/1GB)
            $totalspace=[int]($drive.Size/1GB)
            $usedspace=$totalspace - $freespace

                if ($freespace -lt $warningThreshold) {$message =  "$message WARNING! $comp\$drivename"
                }
                   

$output = @"
Drive : $comp\$drivename 
FreeSpace  : $freespace GB


"@
#write-host $output

                      $outputcombined = $outputcombined + $output
                         }   
             }

        write-host $outputcombined
   
           $emailAddress = "alert@miomni.com"
                            $user = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
                            $port = "587"
			   # $subject = "Disk Space $message"
$subject = "Disk Space GCP $env:computername $message"
                
                            
                           
         Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $outputcombined -From $emailAddress
        write-host $subject
        write-host $message
       

      