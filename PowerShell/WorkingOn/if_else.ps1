#$a = read-host "Enter number"
#if ($a -eq "") {echo "nada"}
#else { echo "something" }

Add-Pssnapin quest.activeroles.admanagement
$days = 20
$date=(get-date).adddays(-$days)
$users = get-qaduser -createdafter $date
$noofusers = $users.count
if ($noofusers -eq 0) {$noofusers = 0}
echo "days = " $days
echo "date" $date
echo "no of users" $noofusers
$users
