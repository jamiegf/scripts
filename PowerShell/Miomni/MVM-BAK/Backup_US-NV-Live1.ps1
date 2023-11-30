﻿#backup US-NV-Live1 (10.10.10.205) (folders and IIS sites & bindings)
#copies yesterdays to todays then compare and sync live server with backup
#

$destFolder = "E:\US-NV-Live1"
$sourceDrive = "\\10.10.10.205\c$"
$retentionDays = 3

$today = Get-Date -format d.M.yyyy
$yesterday = ((get-date).adddays(-1)).tostring('d.M.yyyy') 
$retentionDate = ((get-date).adddays(-$retentionDays)).tostring('d.M.yyyy') 
$logs = "_logs"
$logPath = "$destFolder\$today\$logs"
$wwwrootfolder = "inetpub\wwwroot"
$gamingFolder = "Gaming"
$miomniFolder = "Miomni"
$scriptsFolder = "Scripts"
$configfolder = "Windows\System32\inetsrv\config"

Get-Process robocopy| Stop-Process -force
cd "$destFolder"
new-item $today -ItemType Directory

#copy yesterdays to today
if (test-path $destFolder\$yesterday)
{robocopy $yesterday $today  /r:1 /w:2 /MIR /TEE /NP /NDL /Z}
    else
        {
            New-item "$today" -ItemType Directory
           
           }
           #if any folders did not copy, create them
            if(!(test-path "$today\$wwwrootfolder"))
            {new-item "$today\$wwwrootfolder" -ItemType directory}

            if(!(test-path "$today\$gamingfolder"))
            {New-Item "$today\$gamingfolder" -ItemType directory}

            if(!(test-path "$today\$wwwrootfolder"))
            {New-item "$today\$miomnifolder" -ItemType directory}

            if(!(test-path "$today\$ScriptsFolder"))
            {New-item "$today\$ScriptsFolder" -ItemType directory}

            if(!(test-path "$today\$logs"))
            {New-item "$today\$logs" -ItemType directory }

            if(!(test-path "$today\$configfolder"))
            {New-Item "$today\$configfolder" -ItemType directory}
   

#Compare and sync Source and todays backup
robocopy "$sourceDrive\$wwwrootfolder" "$today\$wwwrootfolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /XD 'DfsrPrivate' 'Pleedata' /LOG:"$logPath\Log_WWWRoot.txt"
robocopy "$sourceDrive\$gamingfolder" "$today\$gamingfolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /XD 'DfsrPrivate' /LOG:"$logPath\Log_Gaming.txt"
robocopy "$sourceDrive\$miomnifolder" "$today\$miomnifolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /XD 'DfsrPrivate' /LOG:"$logPath\Log_Miomni.txt"
robocopy "$sourceDrive\$ScriptsFolder" "$today\$ScriptsFolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /LOG:"$logPath\Log_Scripts.txt"
robocopy "$sourceDrive\$configfolder" "$today\$configfolder" "applicationHost.config" /LOG:"$logPath\Log_IISconfig.txt"
Get-Process robocopy| Stop-Process -force


#purge old
write-host "removing item $retentionDate"
remove-item $retentionDate -Recurse -Force

exit