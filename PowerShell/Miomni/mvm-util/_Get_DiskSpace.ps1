$warningThreshold = 20 # adjust for number of GBs to warn at. 
$comps = "mvm-bak", "mvm-inplay1","mvm-inplay2","mvm-prd1","mvm-prd2","mvm-prd3","mvm-race1", "mvm-race2", "mvm-arr1", "mvm-arr2", "mvm-dc01", "mvm-dc02", "mvm-sql1", "mvm-sql2", "MVM-Test-SQL"
      foreach ($comp in $comps)
      {
        $drives=Get-WmiObject Win32_LogicalDisk -ComputerName $comp -Filter "DriveType = 3" 

        foreach ($drive in $drives){
                   
            $drivename=$drive.DeviceID
            $freespace=[int]($drive.FreeSpace/1GB)
            $totalspace=[int]($drive.Size/1GB)
            $usedspace=$totalspace - $freespace
                if ($freespace -lt $warningThreshold) {$subject =  "Disk Space Warning $comp\$drivename"}
                    else {$subject = "Disk Space"}

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
			   # $subject = "Disk Space"
                            
                            
                           
          Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $outputcombined -From $emailAddress
       

      