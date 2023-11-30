'tells you what automatic services are not started on any machine. runas admin for servers

strComputer = "bytes-4241"
set objWMIServices = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colServices = objWMIServices.ExecQuery _
 ("Select * from Win32_Service where state='Stopped' and StartMode='Auto'")
For each objService in colServices
wscript.echo objService.displayname 
next