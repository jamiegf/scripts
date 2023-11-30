Add-Pssnapin quest.activeroles.admanagement


$sam = Read-Host "Enter sam account name"
$OCSserver = "CN=LC Services,CN=Microsoft,CN=ukbssocs01,CN=Pools,CN=RTC Service,CN=Microsoft,CN=System,DC=bytes,DC=co,DC=uk"

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-ArchivingEnabled'=0 }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-FederationEnabled'=$true }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-InternetAccessEnabled'=$true }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-OptionFlags'=256 }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-PrimaryHomeServer'= $OCSserver }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-PrimaryUserAddress'=("sip:" + $sam + "@bytes.co.uk").ToString() }

Get-QADUser $sam | set-qaduser -oa @{'msRTCSIP-UserEnabled'=$true }

