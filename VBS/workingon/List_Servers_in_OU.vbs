



Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSO.OpenTextFile _
    ("c:\scripts\server_list.txt", 8, True)


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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
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
objTextFile.WriteLine objRecordSet.Fields("Name").Value
objRecordSet.MoveNext
Loop

objTextFile.close