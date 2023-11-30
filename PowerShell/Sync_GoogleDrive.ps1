$sourcePath = "c:\"
$destPath = "l:\test\"
$synchFolder = "GoogleDrive"
$timestamp = Get-Date -format d.M.yyyy
[int]$attempts = 8
 
 
do {
    if(Test-Path "$destPath\$synchFolder")
        {robocopy "$sourcePath\$synchFolder" "$destPath\$synchFolder" /r:1 /w:2 /MIR /TEE /NP /Z /LOG:"c:\scripts\log\Log.$timestamp.txt"
          exit
         }  else {
        write-host "attempting to connect to $destPath\$synchFolder"
         sleep 5
        $attempts--
        }
       }
until ($attempts -eq 0)