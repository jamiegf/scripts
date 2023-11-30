$logfolder = "C:\inetpub\logs\LogFiles\W3SVC1"
Get-ChildItem $logfolder -Include U_ex*.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-60)} | Remove-Item