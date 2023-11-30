  
On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")

set objInputFile = fso.OpenTextFile("c:\scripts\COMPUTERS.txt",1,true)





Do while objInputFile.AtEndOfLine <> True
         strComputer = objInputFile.ReadLine

Set objTextFile = fso.OpenTextFile("c:\scripts\service_status.txt", 8, True)
                                                                                err.number = 0
                                                                                y = false
                                                                                objTextFile.WriteLine vbcrlf
                                                                                'objService = ""
                    Set objWMIService=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
                                                strComputer & "\root\cimv2")
                                                
                    Set colServices = objWMIService.ExecQuery("Select * from Win32_Service where StartMode = 'Auto' and State = 'Stopped' and displayname <> 'Performance Logs and Alerts'")
                                      objTextFile.WriteLine strComputer
                                    if err.number <> 0  then 
                                                                                                                                                y = true : objTextFile.WriteLine strComputer & " is not responding"
                                    else
                                                                                                                                                                                                
                                                                                                                                                x = 0
                                                                                                                                                                For Each objService in colServices
                                                                                                                                                                x = x + 1
                                               
                                        objTextFile.WriteLine ("SERVICE DOWN! : " & objService.Displayname)
                                                
                                                                                                                                                                Next
                                                                                                                                    end if
                        if x = 0 and y = false then objTextFile.WriteLine "All Auto Services Up" & vbcrlf
                        'objTextFile.WriteLine vbcrlf
                        objTextFile.Close

loop


Set objTextFile = fso.OpenTextFile("C:\scripts\service_status.txt", 1, True)


Set objEmail = CreateObject("CDO.Message")
                objEmail.From = "internal.helpdesk@bytes.co.uk"
                objEmail.To = "jamie.garrow-fisher@bytes.co.uk"
                objEmail.Subject = "Automatic Services Report"
                objEmail.TextBody = objTextFile.ReadAll
                objEmail.Configuration.Fields.Item _
                ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
                objEmail.Configuration.Fields.Item _
                ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "exchange.bytes.co.uk"
                objEmail.Configuration.Fields.Item _
                ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
                objEmail.Configuration.Fields.Update
                objEmail.Send
                
                
                objTextFile.close

fso.DeleteFile ("c:\scripts\service_status.txt")



 

 
