$PingMachines = Read-Host "Enter Server Name"

Clear

ForEach($MachineName In $PingMachines) 

{$PingStatus = Gwmi Win32_PingStatus -Filter "Address = '$MachineName'" | 

Select-Object StatusCode 

If ($PingStatus.StatusCode -eq 0) 

{Write-Host $MachineName Ping Success -Fore "Green"} 

Else 

{Write-Host $MachineName Ping Failed -Fore "Red"}}



echo "omg its gordon ramsay"
echo
echo






#pause
Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

