


set objou = getobject("LDAP://OU=Ewell,ou=Laptops,ou=,OU=Bytes Software Services,OU=Divisions,OU=Bytes Technology Group Ltd,DC=Bytes,DC=co,DC=uk")
objou.movehere "LDAP://cn=BUILD-62,ou=computers,dc=Bytes,dc=co,dc=uk", vbNullString

