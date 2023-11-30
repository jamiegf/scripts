Add-PSSnapin quest.activeroles.admanagement
#pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

$exit = 0
$com3 = $null

Write-host "To use 'Memory' value, just hit enter"
write-host " "

# start loop

do 
{

pause
cls



Write-Host " " 
Write-Host " Asset Search / Deploy Script"  
Write-Host " ****************************** " 
Write-Host " " 

Write-Host "Options :                                                                               Last Viewed: $com3" 
write-host "                                                                               $message" -foregroundColor darkyellow
write-host " "
Write-Host "1: Look up a users machine name?" 
write-host " "
Write-Host "2: Show current logged on user on a remote computer" 
write-host " "
Write-Host "3: List applications on a remote computer" 
write-host " "
Write-Host "4: Check when a Windows 7 computer was last restarted" 
Write-Host " "
Write-Host "5: Check when a XP computer was last restarted" 
Write-Host " "
Write-Host "6: Clean up temp distribution files for a remote computer (use after remote install)" 
write-host " "
Write-Host "7: Go to C:\ drive of PC in Memory" 
write-host " "
write-host " "
Write-Host "******* Remote Installations **************" 
write-host " "
Write-Host "8: Acrobat 8" 
Write-Host " "
Write-Host "9: Patch acrobat 8 to 8.1" 
Write-Host " "
Write-Host "10: Acrobat 9" 
Write-Host " "
Write-Host "11: Visio 2007" 
Write-Host " "
Write-Host "12: Project 2007" 
Write-Host " "
Write-Host "13: Sype 5.5" 
Write-Host " "
Write-Host "14: AIM" 
Write-Host " "
Write-Host " ***************************" 
Write-Host " "
Write-Host "15: Exit" 
Write-Host " "
$a = Read-Host "Select 1-15: " 
write-host " "
write-host "********************************************" 

Write-Host " "

switch ($a) 
   {
         #use Quest sanpin to check AD records - search users machine
         1 {
          	         
		  	        $abovenetuser = read-host "Enter users name" 
                    $com3 = $null
                    $abovenetuser2 = $abovenetuser + '*'
                    $abovenetpc = Get-QADComputer | where{$_.description-like $abovenetuser2} 
                    $abovenetpc | fl description, name 
                    
                    $counter = @($abovenetpc).count    
			
			if (!$abovenetpc) {write-host "No machine found" -foregroundcolor darkred}
            elseif ($counter -eq 1)
                {
                Write-host "Logged on user: "
                $com3 = $abovenetpc.name
                $compinfo = gwmi win32_systemenclosure -comp $com3
                 $loggedon = gwmi win32_computersystem -comp $com3
                 write-host $loggedon.username -ForegroundColor green
                 write-host " "
                 Write-host "PC info: "
                 write-host $loggedon.model -ForegroundColor darkyellow
                 write-host $abovenetpc.operatingsystem -ForegroundColor darkyellow
                 Write-Host "SN = " + $compinfo.serialnumber
                 $message = "Saved to Memory! (hit Enter to use)"
                 
                }
          }
         
                #show logged on user
 		2 {
          	$com3 = read-host ("Enter full computer name") 
			write-host " "
			if (!$com3) {write-host "Nothing Entered" -foregroundcolor darkred}
			else {
            Write-Host "please wait..." -ForegroundColor green
            $loggedon = gwmi win32_computersystem -comp $com3
			
			write-host Logged on user : $loggedon.username
			$message = "(press enter to use above computer)"
                }
		   }
                # get installed programs
		3 {
          	$com = $null
            $com = read-host ("Enter full computer name")
            if (!$com) {$com = $com3}
			write-host " "
			Write-Host "please wait..." -ForegroundColor green

			$inv = gwmi win32_product -ComputerName $com | sort-object name | Format-List name , version 

			$inv

          }
          
                  4 {
                  $ErrorActionPreference = "silentlyContinue"
         $boxwin = Read-host "Enter Windows 7 computer name"
         if (!$boxwin) {$boxwin = $com3}
           $yesterday=(Get-Date).AddDays(-3)
           write-host "last 3 days="
            Get-winevent -logname system -computername $boxwin | where{$_.id -eq "6006" -or $_.id -eq "6005"} | where {$_.timecreated -gt $yesterday}
                      
           }
           
                              
           
            5 {
            $ErrorActionPreference = "silentlyContinue"
         $boxxp = Read-host "Enter XP computer name"
         if (!$boxxp) {$boxxp = $com3}
           $yesterday=(Get-Date).AddDays(-3)
           write-host "last 3 days="
            Get-eventlog -logname system -computername $boxxp | where{$_.eventid -eq "6006" -or $_.eventid -eq "6005"} | where {$_.timegenerated -gt $yesterday}
           
           
           }
           
            6 {
           $cleanupcomp = Read-Host "Enter computer name"
           if (!$cleanupcomp) {$cleanupcomp = $com3}
           Remove-Item \\$cleanupcomp\c$\windows\temp\dist\* -recurse
           write-host "Temp files deleted" -foregroundcolor darkyellow
          }
          
         7{
         $cdrive = "\\" + $com3 + "\c$"
         explorer $cdrive
         
          }
          
          
          #*************************************************** deployment************************************************************************#
          
                #install Acrobat 8 standard
        8 {
        write-host "Acrobat 8 Standard install" -ForegroundColor darkyellow
        $box = read-host "Enter Computer Name"
        if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Acro8s -Recurse \\$box\c$\windows\temp\dist\_dist_acro8
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\dist\_dist_acro8\setup.exe") | fl processID

          }
          #patch acro8 to 8.1
         9 {
           write-host "Acrobat 8.1 Patch" -ForegroundColor darkyellow
        $box = read-host "Enter Computer Name"
        if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
          
           ([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c msiexec /p c:\windows\temp\dist\_dist_acro8\AcrobatUpd810_efgj_incr.msp /qn REINSTALL=ALL REINSTALLMODE=omus") | fl processID
           }
             #install Acrobat 9 standard
        10 {
        write-host "Acrobat 9 Standard install" -ForegroundColor darkyellow
        $box = read-host "Enter computer name"
        if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Acro9s -Recurse \\$box\c$\windows\temp\dist\_dist_acro9
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\dist\_dist_acro9\setup.exe") | fl processID

          }
          
            # Install Visio 2007         
           11 {
           write-host "Visio 2007 install" -ForegroundColor darkyellow
                   $box = read-host "Enter computer name"
                   if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Visio_2007 -Recurse \\$box\c$\windows\temp\dist\visio_2007
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\dist\visio_2007\setup.exe /config c:\windows\temp\dist\visio_2007\silent_config.xml") | fl processID
           }
           
                    #install project 2007
                     12 {
                     write-host "Project 2007 install" -ForegroundColor darkyellow
                   $box = read-host "Enter computer name"
                   if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\Project_2007 -Recurse \\$box\c$\windows\temp\dist\Project_2007
([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create("cmd.exe /c c:\windows\temp\dist\Project_2007\setup.exe /config c:\windows\temp\dist\Project_2007\Silent_config.xml") | fl processID
           }
           
            #install skype
                     13 {
                     write-host "Skype Install" -ForegroundColor darkyellow
                   $box = read-host "Enter computer name"
                   if (!$box) {$box = $com3}
        write-host " "
		Write-Host "please wait..." -ForegroundColor green
Copy-Item S:\dist\skype -Recurse \\$box\c$\windows\temp\dist\skype

([WMICLASS]"\\$box\ROOT\CIMV2:win32_process").Create('cmd.exe /c msiexec.exe /i c:\windows\temp\dist\skype\skypesetup.msi /qn /l* "c:\windows\temp\skype.log"') | fl processID

           }
          
                    #AIM Install
                     14 {
                     write-host "Aim Install" -ForegroundColor darkyellow
                   $box = read-host "Enter computer name"
                   if (!$box) {$box = $com3}
                      write-host " "
		              Write-Host "please wait..." -ForegroundColor green
                           Copy-Item S:\dist\AIM -Recurse "\\$box\c$\program files"
                               $shell = New-Object -ComObject WScript.Shell
                                $desktop = "\\$box\c$\users\public\desktop"
                                $startmenu = "\\$box\c$\ProgramData\Microsoft\Windows\Start Menu"
                                $shortcut = $shell.CreateShortcut("$desktop\AIM.lnk")
                                $shortcut2 = $shell.CreateShortcut("$startmenu\AIM.lnk")
                                $shortcut.TargetPath = "c:\program files\aim\aim.exe"
                                $shortcut.IconLocation = "\\$box\c$\Program Files\AIM\aim.exe"
                                $shortcut.Save()
                                $shortcut2.TargetPath = "c:\program files\aim\aim.exe"
                                $shortcut2.IconLocation = "\\$box\c$\Program Files\AIM\aim.exe"
                                $shortcut2.Save()

                         }
          
          

           
           
           
        15 {
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

