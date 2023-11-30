
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100


function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}
$db = "AM_BSS"
$exit = 0


Write-Host "*** Asset LookUp Script - version 1.0 - by jgf ***"
Write-Host " "

# start loop

do 
{
pause
cls



Write-Host " " 
Write-Host "ASSET SCRIPT : database = " $db 
Write-Host "************ " 
Write-Host " " 

Write-Host "Options :"
write-host " "
Write-Host "1: Look up Asset Number"
write-host " "
Write-Host "2: Look up User"
write-host " "
Write-Host "3: Look up Decription"
write-host " "
Write-Host "4: Update"
write-host " "
Write-Host "5: Change Database"
write-host " "
Write-Host "6: Exit"
Write-Host " "
$a = Read-Host "Select 1-6: "

Write-Host " "

switch ($a) 
    { 
        1 {
           write-host "Look Up :"
           $num = read-host "Enter asset number"
           
           Invoke-Sqlcmd -Query ("select * from " + $db + ".dbo.fa_accounts WHERE asset_no = '" +$num + "'") -serverinstance "R630\SQLEXPRESS"
          } 
        2 {
           write-host "Look Up:"
           $name = read-host "Enter User"
           Invoke-Sqlcmd -Query ("select * from " + $db + ".dbo.fa_accounts WHERE userkey like '%" +$name + "%'") -serverinstance "R630\SQLEXPRESS"
          } 
        
        3 {
           write-host "Look Up:"
           $desc = read-host "Enter Description"
           Invoke-Sqlcmd -Query ("select * from " + $db + ".dbo.fa_accounts WHERE desc1 like '%" +$desc + "%'") -serverinstance "R630\SQLEXPRESS"
          }
          
        4 {
           write-host "Update Asset:"
           $updateasset = read-host "Enter Asset Number to Update"
           Invoke-Sqlcmd -Query ("select * from " + $db + ".dbo.fa_accounts WHERE asset_no = '" +$updateasset + "'") -serverinstance "R630\SQLEXPRESS"
           write-host " "
          $uu = read-host "ENTER NEW USE FOR ABOVE ASSET: 
 or press 'c' to cancel
 if no results found above - please press 'c'"
           $u = $uu.toUpper()      
                 if ($u -eq "c") { 
                                    write-host "Cancelled!"
                                 }
          else 
                                 {
          Invoke-Sqlcmd -query ("update " + $db + ".dbo.fa_accounts set userkey = '" + $u + "' where asset_no = '" + $updateasset + "'") -serverinstance "R630\SQLEXPRESS"
          Write-Host "Record Updated!"
          Invoke-Sqlcmd -Query ("select * from " + $db + ".dbo.fa_accounts WHERE asset_no = '" +$updateasset + "'") -serverinstance "R630\SQLEXPRESS"
                                 }
                           
                              }
                                    
        5 {
           $q = Read-Host "Enter Y to change database"
          if ($db -eq "AM_BSS" -and $q -eq "y")
                {$db = "AM_BDS"
                Write-Host "database changed to BDS"
                }
        
          elseif ($db -eq "AM_BDS" -and $q -eq "y")
                {$db = "AM_BSS"
                Write-Host "database changed to BSS"
                } 
        else {Write-Host "no change made"}
          } 
 
 
        6 {
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

