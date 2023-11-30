$today = (Get-Date).DayOfWeek 
if ($today -eq "Friday")
{Write-Host "its friday"}
else {

        #DATE NEXT FRIDAY
        $Friday = @(@(0..7) | % {$(Get-Date).AddDays($_)} | ? {$_.DayOfWeek -ieq "Friday"})[0]
        #date last Friday
        $lastFriday = @(@(0..-7) | % {$(Get-Date).AddDays($_)} | ? {$_.DayOfWeek -ieq "Friday"})[0]
        $friday = $friday.ToString('MM.dd.yyyy')
        if (!(test-path "H:\time\TimeSheet_WE_$friday.xlsm"))
            {
            Copy-Item "H:\Time\TimeSheet_Template.xlsm" "H:\time\TimeSheet_WE_$friday.xlsm"
            }
            else {write-host "file already created"}

        $files = Get-ChildItem H:\Time |? {$_.Name -ne "TimeSheet_Template.xlsm"}
        FOREACH ($file IN $files)
            {if ($file.creationtime -lt $lastFriday)
                    {Move-Item h:\time\$file H:\Time\Archive}

      }}