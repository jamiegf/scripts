
$days = 30
Get-ChildItem C:\inetpub\logs\LogFiles -Include U_ex*.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$days)} | Remove-Item