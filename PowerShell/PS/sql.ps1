Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100


function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}




#$a = Read-Host "Enter number"


#Invoke-Sqlcmd ("update am_bss.dbo.fa_accounts set userkey = 'jason' where asset_no = 'd1002'")
#Invoke-Sqlcmd ("update am_bss.dbo.fa_accounts set userkey = 'jason l' where asset_no = 'd1003'")
# select * from fa_accounts where userkey like '%jamie%'
Invoke-Sqlcmd ("select * from am_bss.dbo.fa_accounts")
#Invoke-Sqlcmd -Query "SELECT * from am_bss.dbo.fa_accounts where assset_no =;'" + $a  + "'" -ServerInstance "R630\SQLEXPRESS"
#Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE asset_no = '" +$a + "'") -serverinstance "R630\SQLEXPRESS"

pause