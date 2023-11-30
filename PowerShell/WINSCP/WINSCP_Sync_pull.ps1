& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\temp\WinSCP.log" /ini=nul `
  /command `
    "open ftps://ftps-shore.oceanwagering.com%7Cftpuser:10A%7C3G%23jy@10.13.193.85/ -certificate=`"`"fe:d4:fb:ee:aa:0e:79:74:f1:07:ed:88:3e:c6:be:5e:c2:48:67:54`"`"" `
    "synchronize remote c:\Temp\Dreamcast_out\*.cdi /hdd/roms/Dreamcast/Test/" `
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
