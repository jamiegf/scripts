filter GetExchangeServers{
$root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
$configpartition = [adsi]("LDAP://CN=Microsoft Exchange,CN=Services," + $root.configurationNamingContext)
$search = New-Object System.DirectoryServices.DirectorySearcher($configpartition)
$search.filter = '(objectclass=msExchExchangeServer)'  
$ExchServer = $search.FindAll()
$ExchServer | foreach {$_.properties.name}
}

GetExchangeServers | ForEach-Object {Get-Wmiobject -namespace root\MicrosoftExchangeV2 -class Exchange_Mailbox -computer $_ | sort-object Size -Descending | select-object -First 10 MailboxDisplayName,Servername,StorageGroupName,StoreName,Size}
