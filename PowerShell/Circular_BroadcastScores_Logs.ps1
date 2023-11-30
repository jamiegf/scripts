$DaysToKeep = 10
$Folder = "C:\Miomni\BGBroadcastScores\logs"

Get-ChildItem $Folder -Include *.txt -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$DaysToKeep)} | Remove-Item 





