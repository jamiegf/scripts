  

set fso = CreateObject("Scripting.FileSystemObject")

set objInputFile = fso.OpenTextFile("c:\scripts\COMPUTERS.txt",1,true)





Do while objInputFile.AtEndOfLine <> True
                                strComputer = objInputFile.ReadLine

Set objTextFile = fso.OpenTextFile("c:\scripts\service_status.txt", 8, True)

                                Set objWMIService=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
                                                strComputer & "\root\cimv2")
                                                
                                Set colServices = objWMIService.ExecQuery("Select * from Win32_Service where StartMode = 'Auto' and State = 'Stopped'")
                                                objTextFile.WriteLine strComputer
                                                if err.number <> 0  then objTextFile.WriteLine strComputer & " is not responding"
                                                x= 0
                                'For Each objService in colServices
									For Each objService in colServices
                                x= x + 1
                                                if objService.Displayname <> "Windows Update" & len(objservice.Displayname) >= 40 then
                                                 objTextFile.WriteLine left(objService.Displayname, 40) & vbTab & objService.State & "!"
                                                else 
                                                if objService.Displayname <> "Windows Update" then _
                                                'objTextFile.WriteLine objService.Displayname & Spce(40 - Len(objService.Displayname)) & vbTab & objService.State & "!"
												 objTextFile.WriteLine objService.Displayname & Space(40 - Len(objService.Displayname)) & vbTab & objService.State & "!" 
                                                
												
									end if 
									next
												'end if
								   
                                  
                                if x = 1 then objTextFile.WriteLine "All Auto Services Up" & vbcrlf
                                objTextFile.WriteLine vbcrlf
                                objTextFile.Close

loop
