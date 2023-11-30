
set oShell= Wscript.CreateObject("WScript.Shell")
oShell.Run "Runas /user:BYTESNET\SERVER.SUPPORT c:\scripts\hta\sql2.hta"
'oShell.Run "Runas /user:BYTESNET\SERVER.SUPPORT " & chr(34) & "cscript.exe C:\SCRIPTS\sql.vbs" & chr(34)
'WScript.Sleep 100
'oShell.Sendkeys "0!ymp!c5200b~"
'Wscript.Quit
