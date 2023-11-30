 $ou = "ou=EU Users,dc=eu,dc=above,dc=net"
 
 Get-QADUser -SearchRoot $ou -IncludeAllProperties | ?{$_.msNPALLOWDialin -ne $true}