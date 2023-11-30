#JGF Cleardown script

# number of days to keep records / logs for
$days = 7

# add any log file here which needs to be renamed
$pathsToRename =  "E:\Gaming\Logs\BookService.txt"
$timestamp = Get-Date -format yyyy.MMMM.dd
    foreach ($pathToRename in $pathsToRename)
        {rename-item -path $pathToRename -newname "$pathToRename.$timestamp.txt"}

#paths of log folders to clear
$paths = "E:\Gaming\logs\BookService","E:\Gaming\logs\RabbitLink", "C:\ProgramData\UltraPlay", "C:\inetpub\logs\LogFiles"


foreach ($path in $paths)
        {Get-ChildItem $path -Include *.txt, *.zip, *.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$days)} | Remove-Item}



