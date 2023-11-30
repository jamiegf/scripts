
$today = ((get-date).adddays(-0)).tostring('yyyy-MM-dd') 

$backUpFolder = "D:\SQLShare\NV-SQL1Backups"


$backUpFolder = "D:\SQLShare\NV-SQL1Backups"
$dbs = Get-ChildItem $backUpFolder\$today -filter *.bak | select basename
$dbs = $dbs.basename
import-module sqlserver


foreach ($db in $dbs)
    {
    Invoke-SqlCmd "USE [master]; ALTER DATABASE [$db] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$db]"
    Restore-SqlDatabase -ServerInstance . -Database $db -BackupFile $backUpFolder\$today\$db.bak
    }