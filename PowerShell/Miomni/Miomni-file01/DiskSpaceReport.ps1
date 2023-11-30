$emailbody = $null
$subject = "Miomni Domain Disk Space"
$comps = Get-Content "c:\scripts\computers.txt"
$SMTPserver = "mail.miomni.com"
$from = "Administrator@miomni.com"
$to = "sysadmin@miomni.com"
$bcc = "sysadmin@miomni.com"

foreach ($comp in $comps)
{
$a = $null # reset $a
gwmi win32_logicaldisk -ComputerName $comp -filter DriveType='3' | %{
$DriveGB = "{0:N2}" -f ($_.FreeSpace / 1GB)
$driveLetter = $_.DeviceID
$a = $a + "$driveLetter =  $DriveGB GB free space left `n"
}
$emailbody = $emailbody + "$comp `n$a `n"
#write-host $comp
#write-host "$a"
}
$emailbody

Send-MailMessage -To $to -from $from -bcc $bcc -smtpServer $SMTPServer -subject $subject -body $emailbody