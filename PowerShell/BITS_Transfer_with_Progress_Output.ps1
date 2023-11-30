

            
Import-Module BitsTransfer

          
# We make a unique display name for the transfer so that it can be uniquely            
# referenced by name and will not return an array of jobs if we have run the            
# script multiple times simultaneously.            

$startTime = Get-Date
$displayName = "tlmNEXUS Downloads " + $startTime


Start-BitsTransfer `
    -ProxyUsage AutoDetect `
    -RetryInterval 60 `
    -Priority Normal `
    -DisplayName $displayName `
    -Source "\\crick\training export$\vega\Virtual Hard Disks\vega.vhdx" `
    -Destination "C:\VM" `
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

