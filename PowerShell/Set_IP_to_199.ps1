#pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

$a = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$a.enablestatic("172.25.2.199", "255.255.255.0")
ipconfig

Pause