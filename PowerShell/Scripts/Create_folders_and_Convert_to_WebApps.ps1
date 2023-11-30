$siteName = "JGFZZZ"
$websitePath = "C:\inetpub\wwwroot\$siteName"

$path = "C:\inetpub\wwwroot\$siteName\hels\chinook\resolve"

$scheduledTime = "03:01"
New-Item $path -type Directory

$webappPath = $path
$sitePath = $path

do {
    $sitePath = split-path $sitePath -resolve
    $sitePathtrunc = $sitePath -replace ".*$siteName"
    $sitePathtrunc = "$siteName" + "$sitePathtrunc"
    $appPoolName = $webappPath -replace ".*$siteName"
    $appPoolName =  "$siteName" + "$appPoolName"
    $appPoolName = $appPoolName  -replace "\\", "_"

    $webappName = Split-path $webappPath -leaf
                
                New-WebAppPool $appPoolName  
                ######  set appPool Properties ##########
                $apppool = Get-Item "IIS:\AppPools\$appPoolName"
                $appPool.managedPipeLineMode = "Classic"
                $appPool.managedRunTimeVersion = "v4.0"
                $appPool.processModel.identityType = "ApplicationPoolIdentity"
                #$appPool.processModel.identityType = "LocalSystem"
                $appPool.processModel.idletimeout = "0"
                $appPool.processModel.loaduserprofile = "True"
                $appPool.recycling.periodicRestart.time = [Timespan] "00:00:00"
                $appPool | Set-Item
                Set-ItemProperty -Path "IIS:\AppPools\$appPoolName" -Name Recycling.periodicRestart.schedule -Value @{value="$scheduledTime"}
                ######## end set appPool Properties  
                           
        New-WebApplication -name $webAppName -site $sitePathtrunc -PhysicalPath $WebappPath -ApplicationPool $appPoolName
    #debug begin  
    write-host "webappNAme  = $webappName"
    Write-Host "webappPath =  $webappPath"
    Write-Host "sitePath = $sitePath"
    write-host "SitePathtrunc = $sitePathtrunc"
    Write-Host "appPoolName = $appPoolname"
    #debug -end
    $webappPath = Split-Path $webappPath -Resolve
    }
     until ($webappPath -eq $websitePath
          )
