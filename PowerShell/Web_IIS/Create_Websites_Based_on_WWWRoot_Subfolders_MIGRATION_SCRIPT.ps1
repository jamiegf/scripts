# JGF migration script
# create websites by their folder names
# RUN AS ADMIN

$webroot = "C:\inetpub\wwwroot"
$webFolders = gci -path $webroot -directory -Exclude "aspnet_client"
$domain = "miomni.com"

foreach ($webFolder in $webFolders) #
    {$sitename= $webFolder.name
        $path = "$webroot\$siteName"
        $hostHeader = "$siteName.$domain"
        #New-Item $path -type Directory
        New-WebAppPool $siteName
        New-Website -Name $siteName -PhysicalPath $path -ApplicationPool $siteName
        New-WebBinding -name $siteName -Protocol https  -HostHeader $hostHeader -Port 443 #-SslFlags 1
        Get-Website $siteName | Get-WebBinding -port 80 | Remove-WebBinding
        #Set-ItemProperty IIS:\AppPools\$siteName -name processModel -value @{userName="wvmiomni\sqladmintest";password="RedRum555";identitytype=3}
        sleep 2
        Start-Website -name $siteName
        get-website $siteName
        Get-WebBinding $siteName
        sleep 1
        
    
    }