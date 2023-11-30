
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


Write-Host "*** Asset Manager Script - version 2.0 - by jgf ***"
Write-Host " "
Write-Host "Notes:"
Write-Host "This is case Insensitive"
Write-Host " "
Write-Host "Have now added looking up computers for programs and the logged on user "
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
Write-Host "1: Look up Assets by Number"
write-host " "
Write-Host "2: Look up Assets by User"
write-host " "
Write-Host "3: Look up Assets by Decription"
write-host " "
Write-Host "4: Update user of an Asset"
write-host " "
Write-Host "5: Change Database"
write-host " "
Write-Host "6: Inventory Query - show what programs are installed on a remote computer"
write-host " "
Write-Host "7: Logged On User - show who is currently logged on to a remote computer"
write-host " "
Write-Host "8: Exit"
Write-Host " "
$a = Read-Host "Select 1-8: "

Write-Host " "

switch ($a) 
    { 
        1 {
           write-host "Look Up :"
           $num = read-host "Enter asset number"
           
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name, fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_code = '" +$num + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010   
          } 
        2 {
           write-host "Look Up:"
           $name = read-host "Enter User"
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name, fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_userkey2 like '%" +$name + "%'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
          } 
        
        3 {
           write-host "Look Up:"
           $desc = read-host "Enter Description"
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name, fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_name like '%" +$desc + "%'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
          }
          
        4 {
           write-host "Update Asset:"
           $updateasset = read-host "Enter Asset Number to Update"
		   if ( $updateasset -eq "") { Write-Host "Nothing entered!"}
		   else {
           Invoke-Sqlcmd -Query ("select fa_code as Asset_No, fa_userkey2 as User_Name, fa_name as Description from " + $db + ".dbo.fa_accounts WHERE fa_code = '" +$updateasset + "'") -serverinstance "UKBSSSQL10" -username sa -password Secure2010
           write-host " "
          $uu = read-host "ENTER NEW USER FOR ABOVE ASSET: 
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
          	$com = read-host ("Enter full computer name")
			write-host " "
			Write-Host "please wait..."

			$inv = gwmi win32_product -ComputerName $com | sort-object name | Format-List name , version 

			$inv

          }
 
 		7 {
          	$com2 = read-host ("Enter full computer name")
			write-host " "
			
			$loggedon = gwmi win32_computersystem -comp $com2
			
			write-host Logged on user : $loggedon.username
			
			

          }
 
 
 
  
        8 {
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

