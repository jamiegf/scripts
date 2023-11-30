$users = "kerry", "graeme", "ollie", "dave", "gary", "joe", "harvey", "jamie", "cristi", "pawel", "rupert", "mike", "sharn", "james", "george", "jess" , "rahul", "dan",`
"kerry2", "graeme2", "ollie2", "dave2", "gary2", "joe2", "harvey2", "jamie2", "cristi2", "pawel2", "rupert2", "mike2", "sharn2", "james2", "george2", "jess2" , "rahul2", "dan2"




foreach ($user in $users) {


	$Localuseraccount = @{
   	Name = $user
   	Password = ("M1pools" | ConvertTo-SecureString -AsPlainText -Force)
   	AccountNeverExpires = $true
   	PasswordNeverExpires = $true
   	Verbose = $true
	}

New-LocalUser @Localuseraccount
Add-LocalGroupMember -Group "mipools-web" -Member $Localuseraccount.Name

}