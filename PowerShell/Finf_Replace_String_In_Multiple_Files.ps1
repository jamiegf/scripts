#just change next line - This is the day the report should have been done. 
[datetime]$date = "04/22/2019" 


#specifiy folder for extra safety
$location = "C:\ReportProcessor-master\ManualProcessing\Production_Change_Date"



$today  = ($date).tostring('MM/dd/yyyy')
$yesterday = (($date).adddays(-1)).tostring('MM/dd/yyyy') 
$twodaysago = (($date).adddays(-2)).tostring('MM/dd/yyyy') 

$sourcepath = "$location\ProductionSource"
$destpath = "$location\Production"

if (test-path "$location\Production") {write-host "Delete Production folder First" ; pause ; exit}

robocopy "$sourcepath" "$destpath" /r:1 /w:2 /MIR /TEE /NP /Z /XF

$configFiles = Get-ChildItem $destPath\*.txt -rec
foreach ($file in $configFiles)
  {
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "#today#", "$today" } |
    Set-Content $file.PSPath
    }

$configFiles = Get-ChildItem $destPath\*.txt -rec
foreach ($file in $configFiles)
  {
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "#yesterday#", "$yesterday" } |
    Set-Content $file.PSPath
    }
$configFiles = Get-ChildItem $destPath\*.txt -rec
foreach ($file in $configFiles)
  {
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "#twodaysago#", "$twodaysago" } |
    Set-Content $file.PSPath
    }