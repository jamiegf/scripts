#Add-Pssnappin quest.activeroles.admanagement
$computer = read-host "Enter name of machine"
get-service -computerName $computer

Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")







