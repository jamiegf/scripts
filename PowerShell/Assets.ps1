
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

#pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}
$db = "AM_BSS"
$exit = 0


Write-Host "*** Asset Manager Script - version 1.0 - by jgf ***"
Write-Host " "
Write-Host "Notes:"
Write-Host "This is case Insensitive"
Write-Host "Enter full asset numbers - ie d1234" 

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
           
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name , fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_code = '" +$num + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010   
          } 
        2 {
           write-host "Look Up:"
           $name = read-host "Enter User"
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name, fa_name as Decscription from " + $db + ".dbo.fa_accounts WHERE fa_userkey2 like '%" +$name + "%'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
          } 
        
        3 {
           write-host "Look Up:"
           $desc = read-host "Enter Description"
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name , fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_name like '%" +$desc + "%'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
          }
          
        4 {
           write-host "Update Asset:"
           $updateasset = read-host "Enter Asset Number to Update"
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name , fa_name as Description from  " + $db + ".dbo.fa_accounts WHERE fa_code = '" +$updateasset + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
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
          Invoke-Sqlcmd -query ("update " + $db + ".dbo.fa_accounts set fa_userkey2 = '" + $u + "' where fa_code = '" + $updateasset + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
          Write-Host "Record Updated!"
          Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name , fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_code = '" +$updateasset + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
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

write-host "adios :)"

