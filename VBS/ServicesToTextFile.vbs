strComputer = "."

set fso = CreateObject("Scripting.FileSystemObject")


'the 2 = write permission, 1= read and 8= append,
'true = if file doesnt exist, it will be created
Set objTextFile = fso.OpenTextFile("c:\users\jamie.garrow-fisher\desktop\Results.txt", 2, True)



Set objWMIService = GetObject("winmgmts:"_
	& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
	
Set colRunningServices = objWMIService.ExecQuery("Select * from WIN32_Service")

for each objService in colRunningServices
objTextFile.WriteLine objService.Displayname & vbtab & objService.State
next






'objTextFile.WriteLine("This is Text" & thisIsAVariable)
