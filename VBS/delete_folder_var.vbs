'deletes a folder called %username%
dim a, b, c, d

'get %username%
Set d= wscript.CreateObject("wscript.network")
c= d.Username

'delete folder
set a = CreateObject ("Scripting.FileSystemObject")
set b = a.GetFolder("\\btgukdat03\TSProfiles$\" & c)
b.Delete