Add-Pssnapin quest.activeroles.admanagement


$phonefile = "C:\scripts\outfile\phonenumbers.htm"

$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"

$ou = "ou=EU Users,dc=eu,dc=above,dc=net"


$userphone = Get-QADUser -searchroot $ou | Sort-Object name


$bb = "<H2>Phone Numbers </H2>"
#$bb= $bb + "<H3>Total = " + $locked1 + "</H3>"


$userphone |convertto-html -Property Name, PhoneNumber, MobilePhone -head $a -body $bb | out-file $phonefile

