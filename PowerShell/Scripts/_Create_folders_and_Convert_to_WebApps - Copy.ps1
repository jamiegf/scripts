$siteName = "JGF911"
$websitePath = "C:\inetpub\wwwroot\$siteName"

$path = "C:\inetpub\wwwroot\$siteName\hels\chinook\resolve"

#$webapptest = "NEWEY\Sites\Default Web Site\tes555"
$TempappPool = "DefaultAppPool"

New-Item $path -type Directory



$webappPath = $path
$sitePath = $path
do {
$sitePath = split-path $sitePath -resolve
$sitePathtrunc = $sitePath -replace ".*$siteName"
$sitePathtrunc = "$siteName" + "$sitePathtrunc"

    $webappName = Split-path $webappPath -leaf
        New-WebApplication -name $webAppName -site $sitePathtrunc -PhysicalPath $WebappPath -ApplicationPool $TempAppPool
    #debug bebin  
    write-host "webappNAme  = $webappName"
    Write-Host "webappPath =  $webappPath"
    Write-Host "sitePath = $sitePath"
    write-host "SitePathtrunc = $sitePathtrunc"
    #debug -end
    $webappPath = Split-Path $webappPath -Resolve
    }
   until ($webappPath -eq $websitePath
          )
