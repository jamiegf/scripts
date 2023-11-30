# Pre Reqs:
# Powershell v5 / Windows 10
# user must be added to the group Hyper-V Administrators
#user must have access to \\crick\training export$\vega 
# vm should be exported to \\crick\training export$\vega\
# path "\\crick\training export$\vega\Virtual Hard Disks\vega.vhdx" should exist
#Hyper-V switch needs to be created (script = \\crick\training export$\Add_V_Switch.ps1)
#right click on script - run with powershell


                 #####  VARIABLES  #######
                $serverVMFolder = "\\crick\training export$\vega"
                $vmDiskFolder = "C:\VM\VMCopy\Virtual Hard Disks"
                $vmXMLFolder = "C:\VM\VMCopy\Virtual Machines"
                $vmImportedFolder = "C:\VM\Imported"
                $vmCopy = "vega"
                $vmName = "vega1"
                


               
##### start of options switch ##########
$exit = 0

do 
{
#pause
cls



Write-Host " " 
Write-Host "IMPORT SCRIPT"
Write-Host "************* " 
Write-Host " " 

Write-Host "Options :"
write-host " "
Write-Host "1: Copy VM from Network"
write-host " "
Write-Host "2: Copy VM from USB Drive"
write-host " "
Write-Host "3: Import VM from computer"
write-host " "
Write-Host "4: Show BITS Transfers"
Write-Host " "
Write-Host "5: Stop all BITS Transfers"
write-host " "
Write-Host "6: Exit"
write-host " "
$a = Read-Host "Select 1-6: "

Write-Host " "

switch ($a) 
    {  
        1 {# "1: Copy VM from Network"
           write-host "Copying VM"
          


                #create folders if not already there
                if (!(Test-Path $vmDiskFolder))
                        {New-Item $vmDiskFolder -ItemType directory }

                if (!(Test-Path $vmXMLFolder))
                        {New-Item $vmXMLFolder -ItemType directory}
                
                #remove existing VM Files
                Remove-Item "$vmDiskFolder\*" -Recurse 
                Remove-Item "$vmXMLFolder\*" -Recurse 

                  #test network path
                 if (!(Test-Path "$serverVMFolder\Virtual Machines"))
                        {Write-Host "Folder $serverVMFolder\Virtual Machines not found"
                        pause
                        break}
                 if (!(Test-Path "$serverVMFolder\Virtual Hard Disks"))
                        {Write-Host "Folder $serverVMFolder\Virtual Hard Disks not found"
                        pause
                        break}

                #get XML VM file
                Copy-Item "$serverVMFolder\Virtual Machines\*.xml" $vmXMLFolder

                #bits transfer the VM Disk
                Import-Module BitsTransfer
                $startTime = Get-Date
                $displayName = "tlmNEXUS Downloads " + $startTime
                Start-BitsTransfer `
                    -ProxyUsage AutoDetect `
                    -RetryInterval 60 `
                    -Priority Normal `
                    -DisplayName $displayName `
                    -Source "$serverVMFolder\Virtual Hard Disks\*.vhdx" `
                    -Destination "$vmDiskFolder" `
                    -Asynchronous
                    

                While(Get-BitsTransfer | Where-Object {$_.JobState -ne "transferred"})
                {
                    ForEach-Object {
                        Clear-Host
        
	                "Transfer Started: $startTime"
                        "Last Update:      $(get-date)"
                 
                        Get-BitsTransfer | Select-Object -ExpandProperty FileList | Sort-Object RemoteName | Format-Table RemoteName, BytesTransferred, BytesTotal, @{Name="Complete (%)";Expression={($_.BytesTransferred/$_.BytesTotal)}; FormatString="P"} -AutoSize | Out-String
                        sleep 5
                        Get-BitsTransfer | Where-Object {$_.JobState -eq "transferred"} | Complete-BitsTransfer
                    }
                }
                Clear-Host
                "Transfer Started: 	$startTime"
                "Transfer Completed:	$(get-date)"
                Get-BitsTransfer | % {"Job ID {0} transferred {1} in {2} minutes" -f $_.jobid, $_.BytesTransferred, [int](New-Timespan -Start $_.CreationTime -End $_.TransferCompletionTime).totalMinutes }
                Get-BitsTransfer | Complete-BitsTransfer


           pause
           
           
          } 
          2 { #"2: Copy VM from USB Drive"
                    
                            #Find drive letter of USB
                        do {
                                $usb = gwmi win32_diskdrive | ?{$_.interfacetype -eq "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid}
                                
                                if ($usb -eq $null)
                                {write-host "please attach USB drive"
                                Pause
                                }
                        }
                        until ($usb -ne $null)

                       
                          #create folders if not already there
                if (!(Test-Path $vmDiskFolder))
                        {New-Item $vmDiskFolder -ItemType directory }

                if (!(Test-Path $vmXMLFolder))
                        {New-Item $vmXMLFolder -ItemType directory}
                
                #remove existing VM Files
                Remove-Item "$vmDiskFolder\*" -Recurse 
                Remove-Item "$vmXMLFolder\*" -Recurse 

                #test USB path
                 if (!(Test-Path "$usb\Virtual Machines"))
                        {Write-Host "Folder $usb\Virtual Machines not found"
                        pause
                        break}
                 if (!(Test-Path "$usb\Virtual Hard Disks"))
                        {Write-Host "Folder $usb\Virtual Hard Disks not found"
                        pause
                        break}


                #get XML VM file
                 write-host "Copying VM from USB Drive"
                Copy-Item "$usb\Virtual Machines\*.xml" $vmXMLFolder
               
                #bits transfer the VM Disk
                Import-Module BitsTransfer
                $startTime = Get-Date
                $displayName = "tlmNEXUS Downloads " + $startTime
                Start-BitsTransfer `
                    -ProxyUsage AutoDetect `
                    -RetryInterval 60 `
                    -Priority Normal `
                    -DisplayName $displayName `
                    -Source "$usb\Virtual Hard Disks\*.vhdx" `
                    -Destination "$vmDiskFolder" `
                    -Asynchronous
                    

                While(Get-BitsTransfer | Where-Object {$_.JobState -ne "transferred"})
                {
                    ForEach-Object {
                        Clear-Host
        
	                "Transfer Started: $startTime"
                        "Last Update:      $(get-date)"
                 
                        Get-BitsTransfer | Select-Object -ExpandProperty FileList | Sort-Object RemoteName | Format-Table RemoteName, BytesTransferred, BytesTotal, @{Name="Complete (%)";Expression={($_.BytesTransferred/$_.BytesTotal)}; FormatString="P"} -AutoSize | Out-String
                        sleep 5
                        Get-BitsTransfer | Where-Object {$_.JobState -eq "transferred"} | Complete-BitsTransfer
                    }
                }
                Clear-Host
                "Transfer Started: 	$startTime"
                "Transfer Completed:	$(get-date)"
                Get-BitsTransfer | % {"Job ID {0} transferred {1} in {2} minutes" -f $_.jobid, $_.BytesTransferred, [int](New-Timespan -Start $_.CreationTime -End $_.TransferCompletionTime).totalMinutes }
                Get-BitsTransfer | Complete-BitsTransfer


           pause
           
           
          } 
        3 {    #"3: Import VM from computer"
        if(!(test-path "$vmXMLFolder\*.xml"))
                {Write-Host "VM needs to be copied first. Please use option 1 or 2"
                pause
                break
                } 
        $xmlpath = ls "$vmXMLFolder\*.xml"
        write-host "Importing VM"

        #create import folder if not already there
        if (!(Test-Path $vmImportedFolder))
        {New-Item $vmImportedFolder -ItemType directory }
       
       
                    #delete current VM
                        $vmexists = Get-VM $vmname -ErrorAction SilentlyContinue
                if ($vmexists -eq $null)

                {write-host "$vmname does not exist"}
                else {
                        Write-Host "Stopping VM : $vmname"
                        Stop-VM $vmName -Force
                        write-host "Deleting existing VM"
                        Remove-VM $vmName -Force
                        Remove-Item "$vmImportedFolder\*" -Recurse 
                }
            #import VM
            Write-Host "importing Virtual Machine and Virtual Machine Hardrive. Please wait"
            import-vm -Path $xmlpath `
            -copy -VhdDestinationPath $vmImportedFolder -VirtualMachinePath $vmImportedFolder -GenerateNewId
            Start-VM $vmCopy

            #rename VM
            write-host "Renaming VM"
            get-vm $vmCopy | rename-vm -newname $vmName
            get-vm $vmName | Restart-VM -Force 


            #ping test equivalent - heartbeat VM OS check
            $vmHeartbeat = Get-VMIntegrationService $vmName -Name heartbeat
            while ($vmHeartbeat.PrimaryStatusDescription -ne "ok")
                    {
                    $vmHeartbeat = Get-VMIntegrationService $vmName -Name heartbeat
                   Write-Host "VM starting up - please wait"
                   sleep 5
                    }
                    write-host "VM is now responding"
                    write-host "Please wait"
                    sleep 5

            $attempts = 5
            DO {$results = gwmi -Query "SELECT * FROM Win32_pingstatus WHERE Address = '$computer'"
                If ($results.statuscode -eq 0) 
                     {$attempts = 0}
                    else
                    {write-host "Did not ping - reattempting..."
                    sleep 5
                    $attempts--}
                    }
                until ($attempts -eq 0)

                If ($results.statuscode -eq 0) 
                    {write-host "Connected! Ready to use!" -ForegroundColor Green
                    }
                    else
                    {Write-Host "timed out - failed to connect"-ForegroundColor Red}


                   pause
          } 
       
    4 { # "4: Show BITS Transfers"
    $btr = Get-BitsTransfer
        if ($btr)
        {$btr | out-string}
        else {write-host "No BITS transfers"}
    write-host " "
    pause
        }       
     
     5 {#"5: Stop all BITS Transfers"
     Get-BitsTransfer | remove-bitstransfer 
     $btr = get-bitstransfer
     if (!$btr) {write-host "All BITS transfers removed!"}
     write-host " "
     pause
        }
        6{ #"6: Exit"
           write-host "exit"
           $exit = 1
          } 
 
   
      
        default {
          "** The selection could not be determined **";
          break;
          }
    }
write-host " "    

} 
until ($exit -eq 1)

write-host "Exiting :)"