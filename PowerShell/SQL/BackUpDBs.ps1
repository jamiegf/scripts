##### BACK UP ALL USER/MIOMNI DATABASES TO NETWORK SHARE ######
#### AND DELETE OLD BACKUPS #######

#amend depending on how many backups are needed / disk space remains
$daysToKeep =  4
$keepDate = (get-date).AddDays(-$daysToKeep)

#ammend days if you want to go back to yesterday, change adddays to -1 etc
$today = ((get-date).adddays(-0)).tostring('yyyy-MM-dd') 

#backup to backupShare 
$backUpFolder = "\\nv-sql2\sqlshare\nv-sql1backups"

#get all DBs minus system DBS
Import-Module sqlserver
 $sqlinstance = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $server
 $userdbs = $sqlinstance.databases  | where { $_.IsSystemObject -eq $False }
 $dbs = $userdbs.name



#create todays folder
New-Item $backUpFolder\$today -ItemType Directory

foreach ($db in $dbs)
    {
    Backup-SqlDatabase -ServerInstance . -Database $db -BackupFile \\nv-sql2\sqlshare\nv-sql1backups\$today\$db.bak
    }


#clean up - delete old baks and folders


# Delete files older than the $keepDate.
Get-ChildItem -Path $backUpFolder -exclude "readme.txt" -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $keepDate } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $backUpFolder -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse