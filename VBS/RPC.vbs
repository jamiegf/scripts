Option Explicit
Dim WshShl
'Define the title bar message to be displayed in the script’s
'pop-up dialog
Const cTitlebarMsg = "The Math Game"
'Instantiate an instance of the WshShell object
Set WshShl = WScript.CreateObject("WScript.Shell")

WshShl.Run "Outlook"
'Pause script execution to give Windows enough time to load WordPad
WScript.Sleep 4000
WshShl.SendKeys "%{t}"
WScript.Sleep 500
WshShl.SendKeys "a"
WScript.Sleep 500
WshShl.SendKeys "%{a}"
WScript.Sleep 500
WshShl.SendKeys "%{m}"
WScript.Sleep 200
WshShl.SendKeys "+{TAB}"
WScript.Sleep 200
WshShl.SendKeys "{RIGHT}"
'WScript.Sleep 500
WshShl.SendKeys "{RIGHT}"
'WScript.Sleep 500
WshShl.SendKeys "{RIGHT}"
'WScript.Sleep 500
WshShl.SendKeys "%{t}"
'WScript.Sleep 500
WshShl.SendKeys "%{e}"
'WScript.Sleep 500
WshShl.SendKeys "exchange.bytes.co.uk"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys " "
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "msstd:exchange.bytes.co.uk"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "{UP}"
WScript.Sleep 1000
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "%{F4}"
'WshShl.SendKeys "%{N}"
