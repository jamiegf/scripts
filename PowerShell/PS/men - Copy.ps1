
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100


function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

$exit = 0


Write-Host "*** Asset LookUp Script - version 1.0 - by jgf ***"
Write-Host " "
do 
{
pause
cls


# Explain what the script does
Write-Host " " 
Write-Host "ASSET SCRIPT"
Write-Host " " 

# Select environment MENU
Write-Host "Options :"
write-host " "
Write-Host "1: Look Up Assets by Number"
Write-Host "2: Look up by Name"
Write-Host "3: Look up by Decription"
Write-Host "4: Update User"
Write-Host "5: Exit "
Write-Host " "
$a = Read-Host "Select 1-5: "

Write-Host " "

switch ($a) 
    { 
        1 {
           write-host "Look Up :"
           $num = read-host "Enter asset number"
           
           Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE asset_no = '" +$num + "'") -serverinstance "R630\SQLEXPRESS"
          } 
        2 {
           write-host "Look Up:"
           $name = read-host "Enter name"
           Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE userkey like '%" +$name + "%'") -serverinstance "R630\SQLEXPRESS"
          } 
        
        3 {
           write-host "Look Up:"
           $desc = read-host "Enter Description"
           Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE desc1 like '%" +$desc + "%'") -serverinstance "R630\SQLEXPRESS"
          }
          
        4 {
           write-host "Update Asset:"
           $updateasset = read-host "Enter Asset to Update"
           Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE asset_no = '" +$updateasset + "'") -serverinstance "R630\SQLEXPRESS"
           write-host " "
          $u = read-host "ENTER NEW USE FOR ABOVE ASSET: 
 or press 'c' to cancel
 if no results found above - please press 'c'"
                 if ($u -eq "c") { 
                                    write-host "Cancelled!"
                                 }
          else 
                                 {
          Invoke-Sqlcmd -query ("update am_bss.dbo.fa_accounts set userkey = '" + $u + "' where asset_no = '" + $updateasset + "'") -serverinstance "R630\SQLEXPRESS"
          Write-Host "Record Updated!"
          Invoke-Sqlcmd -Query ("select * from am_bss.dbo.fa_accounts WHERE asset_no = '" +$updateasset + "'") -serverinstance "R630\SQLEXPRESS"
                                 }
                           
                              }
                                    
        5 {
           write-host "exit"
           $exit = 1
          } 
        default {
          "** The selection could not be determined **";
          break;
          }
    }
write-host " "    

} 
until ($exit -eq 1)

write-host "adios"

