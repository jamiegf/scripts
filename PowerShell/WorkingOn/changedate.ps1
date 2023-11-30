Add-Pssnapin quest.activeroles.admanagement
$date=(get-date).adddays(-30)
get-qaduser -createdafter $date