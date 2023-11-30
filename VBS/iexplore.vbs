Option Explicit
Dim WshShl
'Define the title bar message to be displayed in the script’s
'pop-up dialog
Const cTitlebarMsg = "The Math Game"
'Instantiate an instance of the WshShell object
Set WshShl = WScript.CreateObject("WScript.Shell")

WshShl.Run "iexplore"
'Pause script execution to give Windows enough time to load WordPad
WScript.Sleep 10000
WshShl.SendKeys "%{t}"
WScript.Sleep 2000
WshShl.SendKeys "o"
WScript.Sleep 2000
WshShl.SendKeys "https://global.gotomeeting.com/island/login.tmpl"
WScript.Sleep 500
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "http://www.bytes.co.uk "
WScript.Sleep 1000
WshShl.SendKeys "+{TAB}"
WshShl.SendKeys "+{TAB}"
WshShl.SendKeys "+{TAB}"
WshShl.SendKeys "+{TAB}"
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "{ENTER}"
WScript.Sleep 2000
WshShl.SendKeys "%{F4}"
WScript.Sleep 1000
WshShl.SendKeys "{ENTER}"
WScript.Sleep 2000
WshShl.Run "iexplore"
Wscript.Sleep 10000
WshShl.Sendkeys "internal.helpdesk@bytes.co.uk"
WshShl.Sendkeys "{TAB}"
WshShl.Sendkeys "remote07"
WshShl.Sendkeys "{ENTER}"
WScript.Sleep 1000
WshShl.Sendkeys "^{t}"
WScript.Sleep 1000
WshShl.Sendkeys "%{d}"
WshShl.Sendkeys "www.google.com"
WshShl.Sendkeys "{Enter}"
