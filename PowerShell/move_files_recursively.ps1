Add-PSSnapin quest.activeroles.admanagement
$ouleft = "ou=Z - Left Users,DC=eu,DC=above,DC=net"


get-qaduser -searchroot $ouleft | % {Set-qaduser $_ -phonenumber ($_.phonenumber.replace("+44 207", "+44 20 7"))}