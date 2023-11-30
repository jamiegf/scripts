Option Explicit
DIM SVR 
SVR = INPUTBOX ("Type name of server")
Dim objShell
Set objShell = CreateObject("WScript.Shell")
objShell.Run "%comspec% /c qwinsta /server:" & SVR & " >log12345.txt & notepad log12345.txt"
WScript.Quit 