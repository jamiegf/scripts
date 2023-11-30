$taskFolder = "Miomni"
$taskName = "Miomni Inventory sports v7"
$description = "daily scheduled task to do something or other"


$ErrorActionPreference = "stop"
     $scheduleObject = New-Object -ComObject schedule.service
     $scheduleObject.connect()
     $rootFolder = $scheduleObject.GetFolder("\")
        Try {$null = $scheduleObject.GetFolder($taskFolder)}
        Catch { $null = $rootFolder.CreateFolder($taskFolder) }
        Finally { $ErrorActionPreference = "continue" }

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
-Argument '-NoProfile -WindowStyle Hidden -command "& {cd C:\inetpub\wwwroot\Miomni-v7-Sports-NV-STG\InventoryApp\; start-process -filepath .\MiomniGettingParlayCardsNV7.exe}"'
$trigger =  New-ScheduledTaskTrigger -Daily -At 0am
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$task = Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description $description -TaskPath $taskFolder -Principal $principal
$task.Triggers.Repetition.Duration = "P1D" #Repeat for a duration of one day
$task.Triggers.Repetition.Interval = "PT1M" #Repeat every 1 minute, use PT1H for every hour
$task | Set-ScheduledTask