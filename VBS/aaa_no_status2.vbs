On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")

set objInputFile = fso.OpenTextFile("c:\scripts\COMPUTERS.txt",1,true)
Set objTextFile = fso.OpenTextFile("c:\scripts\service_status.txt", 8, True)




Do while objInputFile.AtEndOfLine <> True
                                strComputer = objInputFile.ReadLine



                                Set objWMIService=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
                                                strComputer & "\root\cimv2")
                                                
                                Set colServices = objWMIService.ExecQuery("Select * from Win32_Service where StartMode = 'Auto' and State = 'Stopped'")
                                                objTextFile.WriteLine strComputer
                                                if err.number <> 0  then objTextFile.WriteLine strComputer & " is not responding"
                                                
												objService = ""
												x= 0
                                For Each objService in colServices
                                x= x + 1
                                               
                                                if objService.Displayname <> "Software Protection" then _
                                                objTextFile.WriteLine objService.Displayname 
                                                
                                  Next
                                if x = 1 then objTextFile.WriteLine "All Auto Services Up" & vbcrlf
                                objTextFile.WriteLine vbcrlf
                                

loop

objTextFile.Close