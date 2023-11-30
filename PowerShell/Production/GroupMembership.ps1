#group membership for everything in AD
Add-PSSnapin quest.activeroles.admanagement
$a = Get-QADUser | Sort-Object
#$b = foreach($a in $a)
$z = $a | ForEach-Object {
$_.samaccountname
$_.memberof | Sort-Object | Get-QADGroup


"________________________"
"   "
"   "




}
$z | Out-File c:\scripts\gmtemp.txt

Get-Content c:\scripts\gmtemp.txt | Where-Object {$_ -notmatch 'Name'} | Where-Object {$_ -notmatch '---'} |out-file c:\scripts\groupmembership.txt
Remove-Item c:\scripts\gmtemp.txt



