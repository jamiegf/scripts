If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}



# ****** EDIT LINE BELOW **********
$siteName = "Miomni-Inplay-UP-STG" 


$path = "C:\inetpub\wwwroot\$siteName"
$hostHeader = "$siteName.miomni.com"
New-Item $path -type Directory
New-WebAppPool $siteName
New-Website -Name $siteName -PhysicalPath $path -ApplicationPool $siteName #-ErrorAction SilentlyContinue
Get-Website $siteName | Get-WebBinding -port 80 | Remove-WebBinding
New-WebBinding -name $siteName -Protocol http  -HostHeader $hostHeader -Port 80 
sleep 2
Start-Website -name $siteName
get-website $siteName
Get-WebBinding $siteName
pause