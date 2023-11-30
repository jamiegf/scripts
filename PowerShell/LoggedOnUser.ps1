$Credential = "Wildnet\adm-jgarrow"
#pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

$m = read-host "Enter computer Name"
$CS = Gwmi Win32_ComputerSystem -Comp $m -Credential $Credential
cls
"Machine Name: " + $CS.Name
"Logged On User: " + $CS.UserName
Write-Host " "
pause