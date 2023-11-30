#need to add Description, and all or org 

#add relevant snapins
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin
Add-Pssnapin quest.activeroles.admanagement


#request varibales
$firstname = Read-Host "Enter First Name"
$surname = Read-Host "Enter Surname"
$password = Read-Host "Enter Password"
$ext = Read-Host "Enter Extension Number"
$Jobtitle = Read-Host "Enter Job Title"
$Dept = Read-Host "Enter Dept"
$Manager = Read-Host "Enter Manager"


#convert input variables
$phoneno = "020 8 786 " + $ext
$fullname = $firstname + " " + $surname
$sam = $firstname + "." + $surname
$email =  $sam + "@bytes.co.uk"

#create user mailbox and AD account
$secPassword = ConvertTo-SecureString -string $password -asPlainText -Force

New-Mailbox -Name $fullname -Database “Mailbox Database 0998949894” -Password $secPassword -UserPrincipalName $email -Alias $sam -DisplayName $fullname -FirstName $firstname -LastName $surname 


#update AD
$a = Get-QADUser $sam
$a.TSProfilePath = "\\btgukdat03\TSProfiles$\" + $sam
$a.HomeDirectory = "\\btgukdat03\home\" + $sam
$a.HomeDrive = "H"
$a.office = "Bytes Software Services"
$a.phoneNumber = $phoneno
$a.webpage = "www.bytes.co.uk"
$a.fax = "020 8393 6622"
$a.LogonScript = "W7.bat"
$a.Description = $Jobtitle
$a.department = $Dept
$a.manager = $Manager
$a.title = $Jobtitle
$a.company = "Bytes Software Services Ltd"
$a.commitChanges()


# create H drive and set permissions
$homedir = New-Item \\btgukdat03\home\$sam -type directory
$acl = Get-Acl $homedir
if ($acl.AreAccessRulesProtected) { $acl.Access | % {$acl.purgeaccessrules($_.IdentityReference)} }
else {
$isProtected = $true 
$preserveInheritance = $false
$acl.SetAccessRuleProtection($isProtected, $preserveInheritance) 
}
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("bytesnet\$sam","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("bytesnet\domain admins","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
Set-Acl -aclobject $ACL -Path $homedir


#create U drive images folder
New-Item \\btgukimg01\images\$sam -type directory

    
#enable OCS and configure OCS settings

$OCSserver = "CN=LC Services,CN=Microsoft,CN=ukbssocs01,CN=Pools,CN=RTC Service,CN=Microsoft,CN=System,DC=bytes,DC=co,DC=uk"
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-ArchivingEnabled'=0 }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-FederationEnabled'=$true }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-InternetAccessEnabled'=$true }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-OptionFlags'=256 }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-PrimaryHomeServer'= $OCSserver }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-PrimaryUserAddress'=("sip:" + $sam + "@bytes.co.uk").ToString() }
Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-UserEnabled'=$true }


