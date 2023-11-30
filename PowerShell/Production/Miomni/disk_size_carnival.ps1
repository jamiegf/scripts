$warningThreshold = 4
 # adjust for number of GBs to warn at. 
$comps = "mvm-bak", "mvm-inplay1","mvm-inplay2","mvm-inplay3","mvm-inplay4","mvm-prd1","mvm-prd2","mvm-prd3","mvm-race1", "mvm-race2", "mvm-race3", "mvm-race4", "mvm-arr1", "mvm-arr2", "mvm-arr3","mvm-dc01", "mvm-dc02","nv-sql1", "mvm-sql1", "mvm-sql2", "MVM-Test-SQL", "MVM-Web2", "MVM-Web"
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
			    $subject = "Disk Space $message"
                
                            
                           
         Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $outputcombined -From $emailAddress
        write-host $subject
        write-host $message
       

      