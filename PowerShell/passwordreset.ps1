add-pssnapin quest.activeroles.admanagement
$a = Read-Host "Enter Username / sam account name"
$b = Read-Host "Enter New Password"
set-QADuser $a -userpassword $b

Read-Host "Press any key to continue"
