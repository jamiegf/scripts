#sync iis sports logs
net use l: \\prd-logs\LogShare\inplay /user:miomni Orange21! /persistent:yes
$day = get-date -format yyyy-MM-dd
[INT]$hour = get-date -format HH
$yesterdayUS = ((get-date).adddays(-1)).tostring('yyyy-MM-dd')  
if ($hour -lt 4)
    {$day = $yesterdayUS}
$source = "C:\inetpub\logs\LogFiles"
$IDFile  =  "c:\miomni\serverID.txt"
    if (-not(test-path $IDFile))
        {new-item $IDFile
        get-date -format "MMM-dd__HH-mm" | out-file $IDFile 
        }
[STRING]$Timestamp = Get-Content $IDFile
robocopy $source l:\$day\Instance-$timestamp\IISLogs  /r:1 /w:2 /E /TEE /NP /NDL /Z
