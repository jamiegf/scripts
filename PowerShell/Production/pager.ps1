 
 #pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
 }
 
$OuDomain = "ou=Bytes Software Services,ou=divisions,ou=Bytes Technology Group Ltd,dc=bytes,dc=co,dc=uk" 

$a = get-qaduser -searchRoot $OuDomain
$b = $a | Where-Object {$_.pager -ne "12345"}
$b



Pause
