' Move a Computer Account to a New Domain


Set objOU = GetObject("LDAP://cn=Computers,dc=NA,dc=fabrikam,dc=com")

objOU.MoveHere 'LDAP://CN=' & strcomputer & 'OU=Citrix Servers,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk', _
    vbNullString
    
    Select Name,Location from 'LDAP://OU=Citrix Servers,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk'" 