# Check Inventory.exes are running - email alert if not up. 

$InventoryPS = Get-Content "C:\inetpub\wwwroot\Inventories.txt"

foreach ($InventoryP in $InventoryPS)
    {$ps = Get-Process $InventoryP -ErrorAction SilentlyContinue
        if ($ps -eq $null) 
        {        
                $emailBody = 
@"
$InventoryP 
is not running on
$env:COMPUTERNAME
"@
                            $emailAddress = "alert@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"
			                $subject = "Inventory Alert! "
                            
                            
                           
           Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $emailAddress
        
         }}
       
 