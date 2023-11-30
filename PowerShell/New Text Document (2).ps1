function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}
$srv= bytes-4507



$regKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$Srv)
$key = $regKey.OpenSubkey(“Software\Microsoft\Windows\CurrentVersion\Uninstall”,$false)
Foreach($branch in $Key.GetSubKeyNames()){$sub = $key.OpenSubkey($branch, $false)
$aaa = $aaa +  $sub.GetValue(“DisplayName”)}

$aaa | Sort-Object
Write-Host $aaa




pause

