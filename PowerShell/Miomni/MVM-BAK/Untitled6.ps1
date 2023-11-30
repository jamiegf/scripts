$yesterday = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') 


& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\temp\log\WinSCP.log" /ini=nul `
  /command `
    "open sftp://miomni@64.141.194.98/ -hostkey=`"`"ssh-rsa 2048 OEptbpP5cCoJ9N3M3XdHh6C0atwC9UY4waVPjhkskmo=`"`" -privatekey=`"`"C:\Certificates\miomni.ppk`"`"" `
    "put E:\Wager_Logs\caesars\$yesterday.csv, /nvmobilesports/dropoff/"`    # -resumesupport=off" `
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
  Write-Host "Success"
}
else
{
  Write-Host "Error"
}

exit $winscpResult
