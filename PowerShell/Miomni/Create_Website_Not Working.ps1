# Ensure to run as admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

#ammend this:
$siteName = "test-56789"

#nothing more should need changing
$path = "C:\inetpub\wwwroot\$siteName"
$hostHeader = "$siteName.miomni.com"
New-Item $path -type Directory
New-WebAppPool $siteName
New-Website -Name $siteName -PhysicalPath $path -ApplicationPool $siteName
New-WebBinding -name $siteName -Protocol https  -HostHeader $hostHeader -Port 443 #-SslFlags 1
Get-Website $siteName | Get-WebBinding -port 80 | Remove-WebBinding

