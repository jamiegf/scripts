net use l: \\prd-logs\LogShare /user:miomni Orange21! /persistent:yes
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
robocopy $source l:\Sports\$day\Instance-$timestamp\IISLogs  /r:1 /w:2 /E /TEE /NP /NDL /Z
$source = "C:\Gaming"
robocopy $source l:\Sports\$day\Instance-$timestamp\Gaming  /r:1 /w:2 /E /TEE /NP /NDL /Z
remove-item -path $IDFile -force
