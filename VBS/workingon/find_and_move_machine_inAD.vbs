'On Error Resume Next

Const ADS_SCOPE_SUBTREE = 2

Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection

objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 

objCommand.CommandText = _
    "SELECT ADsPath FROM 'LDAP://dc=Bytes,dc=co,dc=uk' WHERE objectCategory='computer' " & _
        "AND name='BYTES-4352'"
Set objRecordSet = objCommand.Execute

objRecordSet.MoveFirst
Do Until objRecordSet.EOF
    strADsPath = objRecordSet.Fields("ADsPath").Value
    Set objOU = GetObject("LDAP://OU=Restricted,OU=Desktops,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk")
    intReturn = objOU.MoveHere(strADsPath, vbNullString)
    objRecordSet.MoveNext
Loop
msgbox "done"