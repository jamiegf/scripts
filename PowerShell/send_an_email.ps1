$comp = mi01exch001

$Cdrive  = gwmi win32_logicaldisk -ComputerName $comp | where {$_.deviceID -eq "C:"}
 $CGB = "{0:N2}" -f ($Cdrive.FreeSpace / 1GB)
 $CGB
 write-host "C drive space available  =  $CGB GB" 

 $Edrive  = gwmi win32_logicaldisk -ComputerName $comp | where {$_.deviceID -eq "E:"}
 $EGB = "{0:N2}" -f ($Edrive.FreeSpace / 1GB)
 $EGB
 write-host "E drive space available  =  $EGB GB" 