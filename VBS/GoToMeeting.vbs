Option Explicit
Dim WshShl
Set WshShl = WScript.CreateObject("WScript.Shell")
WshShl.Run "iexplore"
WScript.Sleep 5000
WshShl.Sendkeys "%{d}"
WshShl.SendKeys "https://www1.gotomeeting.com/island/login.tmpl?Portal=www.gotomeeting.com"
WshShl.SendKeys "{ENTER}"
WScript.Sleep 7000
WshShl.SendKeys "internal.helpdesk@bytes.co.uk"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "remote07"	
WshShl.SendKeys "{ENTER}"




