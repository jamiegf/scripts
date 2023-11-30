
#pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

$exit = 0




# start loop

do 
{
pause
cls



Write-Host " " 
Write-Host " Asset Search Script"
Write-Host " ****************** " 
Write-Host " " 

Write-Host "Options :"
write-host " "
Write-Host "1: Look up a users machine name?"
write-host " "
Write-Host "2: Show current logged on user on a remote computer"
write-host " "
Write-Host "3: List applications on a remote computer"
write-host " "
Write-Host "4: Install Acrobat 8 to a remote computer"
Write-Host " "
Write-Host "5: Install Acrobat 9 to a remote computer"
Write-Host " "
Write-Host "6: Check when a Windows 7 computer was last restarted"
Write-Host " "
Write-Host "7: Check when a XP computer was last restarted"
Write-Host " "
Write-Host "8: Exit"
Write-Host " "
$a = Read-Host "Select 1-8: "

Write-Host " "

switch ($a) 
   {
         
         1 {
          	
		  	        $abovenetuser = read-host "Enter start of users surname"
                    $abovenetuser2 = $abovenetuser + '*'
                    $abovenetpc = Get-QADComputer | where{$_.description-like $abovenetuser2} | ft description, name 
                        
			$abovenetpc     #$abovenetpc.description
			#write-host $abovenetpc.name
			if ($abovenetpc -eq $null) {write-host "No single machine found"}

          }
         
  
 		2 {
          	$com2 = read-host ("Enter full computer name")
			write-host " "
			Write-Host "please wait..." -ForegroundColor green
			
			$loggedon = gwmi win32_computersystem -comp $com2
			
			write-host Logged on user : $loggedon.username
			
		   }
 
		3 {
          	$com = read-host ("Enter full computer name")
			write-host " "
			Write-Host "please wait..." -ForegroundColor green

			$inv = gwmi win32_product -ComputerName $com | sort-object name | Format-List name , version 

			$inv

          }
 
        4 {
        $box = read-host "Enter Computer Name"
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Acro8s -Recurse \\$box\c$\windows\temp\_dist_acro8
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\_dist_acro8\setup.exe") | ft processID

          }
             
        5 {
        $box = read-host "Enter computer name"
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Acro9s -Recurse \\$box\c$\windows\temp\_dist_acro9
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\_dist_acro9\setup.exe") | ft processID

          }
         6 {
         $box1 = Read-host "Enter Windows 7 computer name"
           $yesterday=(Get-Date).AddDays(-3)
           write-host "last 3 days="
            Get-winevent -logname system -computername $box1 | where{$_.id -eq "6006" -or $_.id -eq "6005"} | where {$_.timecreated -gt $yesterday}
           
           
           }
            7 {
         $box1 = Read-host "Enter XP computer name"
           $yesterday=(Get-Date).AddDays(-3)
           write-host "last 3 days="
            Get-eventlog -logname system -computername $box1 | where{$_.eventid -eq "6006" -or $_.eventid -eq "6005"} | where {$_.timegenerated -gt $yesterday}
           
           
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

