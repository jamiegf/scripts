$today = Get-Date -format dd.MMM.yy
$source = "c:\scripts"
$dest = "C:\temp\dest"

$logfile = "c:\temp\$today.txt"
$errorlog = "c:\scripts\Logs\errorlog.txt"
$SourceCount = (Get-ChildItem $source -file -Recurse).count
Remove-Item $dest  -Recurse -force
xcopy $source $dest /E /C /R /I /K /Y > $logfile
$DestCount = (Get-ChildItem $dest -file -Recurse).count
if ($DestCount -eq $SourceCount)
{Add-Content $logfile "Item Count : Source Count = $SourceCount , Destination Count = $DestCount = All items copied"}
else {
Add-Content $logfile "MISMATCH!!!! : Source Count = $SourceCount , Destination Count = $DestCount"
Add-Content $errorlog "$today"
}


 