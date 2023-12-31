$webAppName = "testJGF444"
$Site = "Default Web Site"
$path = "C:\inetpub\wwwroot\$webAppName"
$VirtualDirectoryPath = "$Site/$webAppName"
$commonName = "CommonFiles"
$commonFilePath = "c:\temp"
$scheduledTime = "03:00"


Import-Module webadministration

New-Item $path -type Directory

New-WebAppPool $webAppName
New-WebApplication -name $webAppName -site $site -PhysicalPath $path -ApplicationPool $webAppName

#new-item $commonFilePath -type Directory
New-WebVirtualDirectory -site $VirtualDirectoryPath -name $commonName -PhysicalPath $commonFilePath

######  set App Pool Properties ##########
$apppool = Get-Item "IIS:\AppPools\$webAppName"

$appPool.managedPipeLineMode = "Classic"
$appPool.managedRunTimeVersion = "v4.0"
$appPool.processModel.identityType = "ApplicationPoolIdentity"
#$appPool.processModel.identityType = "LocalSystem"
$appPool.processModel.idletimeout = "0"
$appPool.processModel.loaduserprofile = "True"
$appPool.recycling.periodicRestart.time = [Timespan] "00:00:00"
$appPool | Set-Item
Set-ItemProperty -Path "IIS:\AppPools\$webAppName" -Name Recycling.periodicRestart.schedule -Value @{value="$scheduledTime"}





