#WIsql "10.161.2.16", 5041  sql     
#WIweb "10.161.2.16", 5043

#MGweb "10.161.2.25", 5043
#MGsql "10.161.1.17", 5011  sql
# ENDPOINT CHECKER
$wiSQL = "10.161.1.16"
$mgSQL = "10.161.1.17"
$WIweb = "10.161.2.16"
$mgWeb = "10.161.2.25"
$wiSQLport = "5011"
$mgSQLport = "5011"
$WIwebport = "5041"
$mgWebport = "5043"

################################################################################################
# WheelingIsland Web
$WIwebConn = ""
$WIwebConn = New-Object System.Net.Sockets.TcpClient("$WIweb", $WIwebport)
if (!$WIwebConn)
    {        
                $emailBody = 
@"
Web connection failed to
$WIweb : $WIwebport
Wheeling Island Web


"@
                            $fromAddress = "WVAlerts@miomni.com"
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "wvalertsgroup@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "EndPoint Connection Failure! "
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $fromAddress}
        
########################################################################
#MardiGras Web 

$MGwebConn = ""
$MGwebConn = New-Object System.Net.Sockets.TcpClient("$mgWeb", $mgWebport)
if (!$MGwebConn)
    {        
                $emailBody = 
@"
Web connection failed to 
$mgWeb : $mgWebport 
Mardigras Web


"@
                            $fromAddress = "WVAlerts@miomni.com"
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "wvalertsgroup@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "EndPoint Connection Failure! "
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $fromAddress}


           ##############################


#Wheeling Island SQL

$WISQLConn = ""
$WISQLConn = New-Object System.Net.Sockets.TcpClient("$wiSQL", $wiSQLport)
if (!$WISQLConn)
    {        
                $emailBody = 
@"
Web connection failed to 
$wiSQL : $wiSQLport
Wheeling Island SQL


"@
                            $fromAddress = "WVAlerts@miomni.com"
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "wvalertsgroup@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "EndPoint Connection Failure! "
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $fromAddress}



           ############################

#Wheeling Island SQL

$mgSQLConn = ""
$mgSQLConn = New-Object System.Net.Sockets.TcpClient("$mgSQL", $mgSQLport)
if (!$mgSQLConn)
    {        
                $emailBody = 
@"
Web connection failed to 
$mgSQL : $mgSQLport
Wheeling Island SQL


"@
                            $fromAddress = "WVAlerts@miomni.com"
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "wvalertsgroup@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "EndPoint Connection Failure! "
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $fromAddress}
        