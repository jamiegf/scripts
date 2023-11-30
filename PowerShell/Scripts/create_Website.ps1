

$siteName = "JGFZZZ"
$websitePath = "C:\inetpub\wwwroot\$siteName"



New-Item $webSitePAth -type Directory

New-Website -Name $siteName -Port 80 -PhysicalPath $websitePath