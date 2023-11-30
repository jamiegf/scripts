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
$z | Out-File c:\gmtemp.txt

Get-Content c:\gmtemp.txt | Where-Object {$_ -notmatch 'Name'} | Where-Object {$_ -notmatch '---'} |out-file c:\groupmembership.txt
Remove-Item c:\gmtemp.txt



