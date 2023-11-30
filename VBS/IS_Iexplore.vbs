Option Explicit
Dim WshShl
'Define the title bar message to be displayed in the script’s
'pop-up dialog
Const cTitlebarMsg = "The Math Game"
'Instantiate an instance of the WshShell object
Set WshShl = WScript.CreateObject("WScript.Shell")

WScript.Sleep 11000
WshShl.Run "iexplore"
WScript.Sleep 10000
WshShl.SendKeys "%{t}"
WScript.Sleep 2000
WshShl.SendKeys "o"
WScript.Sleep 2000
WshShl.SendKeys "http://google.co.uk"
WScript.Sleep 500
WshShl.SendKeys "{ENTER}"
WshShl.SendKeys "https://exchange.bytes.co.uk/intranet/"
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
WshShl.Sendkeys "^{t}"
WScript.Sleep 2000
WshShl.Sendkeys "%{d}"
WScript.Sleep 2000
WshShl.Sendkeys "http://btgukmsw01.bytes.co.uk/MSWSMTP/Common/Home/"
WshShl.Sendkeys "{Enter}"
WScript.Sleep 2000
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 500
WshShl.Sendkeys "{TAB}"
WScript.Sleep 1000
WshShl.Sendkeys "{ENTER}"
WScript.Sleep 500
WshShl.Sendkeys "administrator"
WshShl.Sendkeys "{TAB}"
WshShl.Sendkeys "remote"
WshShl.Sendkeys "{ENTER}"
WshShl.Run "outlook"


