
#runas admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}



$exit = 0
$source = "\\crick\training export$\vega"
$destination = "C:\VM"
do 
{
#pause
cls



Write-Host " " 
Write-Host "IMPORT SCRIPT"
Write-Host "************* " 
Write-Host " " 

Write-Host "Options :"
write-host " "
Write-Host "1: Copy VM from Network"
write-host " "
Write-Host "2: Import VM from computer"
write-host " "
Write-Host "3: Exit"
Write-Host " "
$a = Read-Host "Select 1-3: "

Write-Host " "

switch ($a) 
    { 
        1 {
           write-host "Copying VM"
           Import-Module BitsTransfer
    Start-BitsTransfer -Source $Source -Destination $Destination -Description "Backup" -DisplayName "Backup"
           pause
           
           
          } 
        2 {write-host "Importing VM"
           pause
          } 
       
          
     
  3 {
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