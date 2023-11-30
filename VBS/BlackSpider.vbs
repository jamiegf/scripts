Option Explicit
Dim WshShl
Set WshShl = WScript.CreateObject("WScript.Shell")
WshShl.Run "iexplore"
WScript.Sleep 5000
WshShl.Sendkeys "%{d}"
WshShl.SendKeys "https://www.mailcontrol.com/login/login_form.mhtml"
WshShl.SendKeys "{ENTER}"
WScript.Sleep 4000
WshShl.SendKeys "jamie.garrow-fisher@bytes.co.uk"
WshShl.SendKeys "{TAB}"
WshShl.SendKeys "Rux242424"	
WshShl.SendKeys "{ENTER}"




