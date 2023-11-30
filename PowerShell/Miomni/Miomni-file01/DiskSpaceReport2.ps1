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


$b = Get-WmiObject Win32_Service  |
Where-Object { $_.StartMode -eq 'Auto' -and $_.State -ne 'Running' } | 
# process them; in this example we just show them:
Format-Table -AutoSize @(
    'Name'
   'DisplayName'
    @{ Expression = 'State'; Width = 9 }
    @{ Expression = 'StartMode'; Width = 9 }
    'StartName'
)

}
$emailbody = $emailbody + "$comp `n$a `n$b"
#write-host $comp
#write-host "$a"
}
$emailbody

Send-MailMessage -To $to -from $from -bcc $bcc -smtpServer $SMTPServer -subject $subject -body $emailbody