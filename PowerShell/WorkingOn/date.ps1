Add-Pssnapin quest.activeroles.admanagement


$days = 30
$date=(get-date).adddays(-$days)
echo $date


$a =get-qaduser -createdafter $date
$b =$a.count
echo $b
