# run as administrator
# add $path to create windows folders, virtual directory and webapps
# webapps will not be overwritten with new settings if they exist


import-module webadministration
$siteName = "TRAINING"

$path = "d:\inetpub\wwwroot\$siteName\AIRSUPPORT\sentry\resolve"

$websitePath = "D:\inetpub\wwwroot\$siteName"

$scheduledTime = "03:02"
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
           try {Get-WebAppPoolState -Name $appPoolName | Out-Null
                Write-Output "AppPool $appPoolName already exists"
                } catch {
                    Write-Output "Creating AppPool $appPoolName ..."
                    New-WebAppPool -name $appPoolName  
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
                }
    if (Get-WebApplication "$webAppName")
    {write-host "Webapp $webAppName already exists"}
        else {Write-Host "Creating Webapp $webAppName ..."
               New-WebApplication -name $webAppName -site $sitePathtrunc -PhysicalPath $WebappPath -ApplicationPool $appPoolName
                }
    #debug begin  
    #write-host "webappNAme  = $webappName"
    #Write-Host "webappPath =  $webappPath"
    #Write-Host "sitePath = $sitePath"
    #write-host "SitePathtrunc = $sitePathtrunc"
    #Write-Host "appPoolName = $appPoolname"
    #debug -end
    $webappPath = Split-Path $webappPath -Resolve
    }
     until ($webappPath -eq $websitePath
          )
