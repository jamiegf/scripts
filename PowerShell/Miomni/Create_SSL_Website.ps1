If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}



# ****** EDIT LINE BELOW **********
$siteName = "MardiGras-TestB" # without miomni.com


$path = "C:\inetpub\wwwroot\$siteName"
$hostHeader = "$siteName.miomni.com"
New-Item $path -type Directory
New-WebAppPool $siteName
New-Website -Name $siteName -PhysicalPath $path -ApplicationPool $siteName
New-WebBinding -name $siteName -Protocol https  -HostHeader $hostHeader -Port 443 #-SslFlags 1
Get-Website $siteName | Get-WebBinding -port 80 | Remove-WebBinding


#New-Website -Name $siteName -Port 80 -HostHeader $hostHeader -PhysicalPath $path -ApplicationPool $siteName


#New-WebBinding -name $iisSite -Protocol https  -HostHeader $hostname -Port 443 -SslFlags 1

Pause