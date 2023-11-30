strComputer = "gblonl01276"
strCommand = "S:\Dist\acro8s\setup.exe"


Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objProcess = objWMIService.Get("Win32_Process")


errReturn = objProcess.Create(strCommand, null, null, intProcessID)


If errReturn = 0 Then
Wscript.Echo "started with a process ID: " & intProcessID
Else
Wscript.Echo "could not be started due to error: " & errReturn
End If

