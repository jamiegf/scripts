On Error Resume Next






Set FSO = CreateObject("Scripting.FileSystemObject")



Set objServerList = FSO.OpenTextFile _
    ("c:\scripts\COMPUTERS.txt", 8, True)


Const ADS_SCOPE_SUBTREE = 2
Set objConnection = CreateObject("ADODB.Connection")
Set objCommand = CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCOmmand.ActiveConnection = objConnection

'get CTX Servers

objCommand.CommandText = _
"Select Name,Location from 'LDAP://OU=Citrix Servers,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop

'Get BSS Servers
objCommand.CommandText = _
"Select Name, Location from 'LDAP://OU=Servers,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop


'get BDS Servers
objCommand.CommandText = _
"Select Name, Location from 'LDAP://OU=Servers,OU=Bytes Document Solutions,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop

'get DCs
objCommand.CommandText = _
"Select Name, Location from 'LDAP://OU=Domain Controllers,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop

'get Servers from _old_BTG_Software Services

objCommand.CommandText = _
"Select Name, Location from 'LDAP://OU=Servers,OU=_old_BTG Software Services,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop


'get Servers from _old_BTG_Software Services\Terminal Servers

objCommand.CommandText = _
"Select Name, Location from 'LDAP://OU=Terminal Servers,OU=Servers,OU=_old_BTG Software Services,DC=Bytes,DC=co,DC=uk'" _
& "Where objectCategory='computer'"
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst
Do Until objRecordSet.EOF
objServerList.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop

objServerList.close


'Set fso = CreateObject("Scripting.FileSystemObject")

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



