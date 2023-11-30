Dim UserID
UserID = Inputbox ("Enter Display Name","Find User") 'Change to the user id you want


Set objConn = CreateObject("ADODB.Connection")
objConn.Provider = "ADsDSOObject"
objConn.Open "Active Directory Provider"

Dim Base, Filter, Attr, Level, Server
Server = "btgukdc02" 'Change to your domain controller you want to query from

Base = "<LDAP://" & Server & "/DC=BYTES,DC=CO,DC=UK>;"  ' Change DC=Corp,DC=Com to your structure
Filter = "(&(objectClass=user)(objectCategory=person)(displayName=" & UserID & "));"
Attr = "distinguishedName;"
Level = "SubTree"

Set RecordSet = objConn.Execute(Base & Filter & Attr & Level)

RecordSet.MoveFirst
While Not RecordSet.EOF
    msgbox RecordSet.Fields(0).Value
    RecordSet.MoveNext
Wend 