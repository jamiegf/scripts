#backup Live (folders and IIS sites & bindings
Get-Process robocopy| Stop-Process -force
$timestamp = Get-Date -format d.M.yyyy
$logPath = "C:\Temp\$timestamp"
$sourceDrive = "\\mgnvprd-02\c$"
$wwwrootfolder = "inetpub\wwwroot"
$gamingFolder = "Gaming"
$miomniFolder = "Miomni"
$scriptsFolder = "Scripts"
$configfolder = "Windows\System32\inetsrv\config"
Write-Host $timestamp
new-item $logpath -ItemType directory 
robocopy "$sourceDrive\$wwwrootfolder" "c:\$wwwrootfolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /LOG:"$logPath\Log_Failover_WWWRoot.txt"
robocopy "$sourceDrive\$gamingfolder" "c:\$gamingfolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /LOG:"$logPath\Log_Failover_Gaming.txt"
robocopy "$sourceDrive\$miomnifolder" "c:\$miomnifolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /XF *.csv *.crk /LOG:"$logPath\Log_Failover_Miomni.txt"
robocopy "$sourceDrive\$ScriptsFolder" "c:\temp\$ScriptsFolder" /r:1 /w:2 /MIR /TEE /NP /NDL /Z /LOG:"$logPath\Log_Failover_Scripts.txt"
robocopy "$sourceDrive\$configfolder" "c:\$configfolder" "applicationHost.config" /LOG:"$logPath\Log_Failover_IISconfig.txt"  #/r:1 /w:2 /MIR /TEE /NP /NDL /Z /LOG:"c:\temp\Log_Failover_IISconfig.$timestamp.txt"
Get-Process robocopy| Stop-Process -force
exit