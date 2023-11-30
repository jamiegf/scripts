$DaysToKeep = 30
$Folder = "C:\inetpub\logs\LogFiles"

Get-ChildItem $Folder -Include U_ex*.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$DaysToKeep)} | Remove-Item 





