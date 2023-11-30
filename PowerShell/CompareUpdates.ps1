$comp1 = "."
$comp2 = "."
$a = gwmi -Class "win32_quickfixengineering" -computer $comp1| select  Description, HotfixID |sort-object HotFixID 
$b = gwmi -Class "win32_quickfixengineering" -computer $comp2| select  Description, HotfixID |sort-object HotFixID 
#$a = get-content "H:\updates.txt"
#$b = Get-Content "H:\updates2.txt"
$c = Compare-Object $a $b
if (!$c) {write-Host "no diff"}
else {write-Host "diff"}
write-host $c

