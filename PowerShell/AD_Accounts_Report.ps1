
Add-Pssnapin quest.activeroles.admanagement
$totalusers = @(get-qaduser).count
$days = 30
$date =(get-date).adddays(-$days)
$newusers = @(get-qaduser -createdafter $date).count

$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"
$c = get-qaduser -NotLoggedOnFor $days
$d = $c.count
$admins = @(Get-QADUser -MemberOf "domain admins" -CreatedAfter $date ).count

$b = "<H2>Users that have not logged in for the last " + $days + " days</H2>"
$b= $b + "<H3>Total = " + $d + "</H3>"

$bb = "<H2>Domain Admins created in the last " + $days + " days</H2>"
$bb= $bb + "<H3>Total = " + $admins + "</H3>"

$bbb = "<H2>Users created in the last " + $days + " days</H2>"
$bbb= $bbb + "<H3>Total = " + $newusers + "</H3>"

Get-QADUser -NotLoggedOnFor $days | Sort-Object name | 
convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $b | out-file c:\scripts\inactive.htm

Get-QADUser -MemberOf "Domain Admins" -CreatedAfter $date | Sort-Object name | 
convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $bb | out-file c:\scripts\domainadmins.htm

Get-QADUser -CreatedAfter $date | Sort-Object name | 
convertto-html -Property Name, CreationDate, LastLogonTimeStamp, LogonName -head $a -body $bbb | out-file c:\scripts\newusers.htm




$SMTPserver = "mail.miommni.com"
$fileattachment = "c:\scripts\newusers.htm", "c:\scripts\domainadmins.htm", "c:\scripts\inactive.htm"
$from = "Internal.Helpdesk@miomni.com"
$to = "jamie.garrow-fisher@miomni.com"
$subject = "Active Directory Users Report"
$emailbody = @"
Total Number of accounts in domain = $totalusers

 Domain admins created in last $days days = $admins

 New users created in last $days days = $newusers

 Number of inactive accounts in last $days days = $d

"@



Send-MailMessage -To $to -from $from -attachments $fileattachment -smtpServer $SMTPServer -subject $subject -body $emailbody











