If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

Import-Module WebAdministration

# ****** EDIT LINE BELOW **********
$siteName = "Jamiegf-test444" 

$domain = "miomni.com"

$path = "C:\inetpub\wwwroot\$siteName"
$hostHeader = "$siteName.$domain"
New-Item $path -type Directory
New-item "$path\test.txt" -ItemType File
"$siteName on $env:computername"  | out-file "$path\test.txt"
New-WebAppPool $siteName
New-Website -Name $siteName -PhysicalPath $path -ApplicationPool $siteName
New-WebBinding -name $siteName -Protocol https  -HostHeader $hostHeader -Port 443 #-SslFlags 1
Get-Website $siteName | Get-WebBinding -port 80 | Remove-WebBinding
#remove line below if AppPool doesnt need extra domain permissions
Set-ItemProperty IIS:\AppPools\$siteName -name processModel -value @{userName="miomni\miomni.nexus";password="6z6R8U1W6Aa9NLUJGe6U";identitytype=3}
sleep 2
Start-Website -name $siteName
get-website $siteName
Get-WebBinding $siteName
pause

