                                                                     
                                                                     
                                                                     
                                             
# This script will Query the Uninstall Key on a computer specified in $computername and list the applications installed there 
# $Branch contains the branch of the registry being accessed 
#  ' 

# format of Computerlist.csv 
# Line 1 - NameOfComputer 
# Line 2 etcetc etc etc etc An Actual name of a computer 



#pause function
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host " "
}




$COMPUTERS= read-host ("type computer name")

FOREACH ($PC in $COMPUTERS) { 
$computername=$PC.NameOfComputer 

# Branch of the Registry 
$Branch='LocalMachine' 

# Main Sub Branch you need to open 
$SubBranch="SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall" 

$registry=[microsoft.win32.registrykey]::OpenRemoteBaseKey('Localmachine',$computername) 
$registrykey=$registry.OpenSubKey($Subbranch) 
$SubKeys=$registrykey.GetSubKeyNames() 

# Drill through each key from the list and pull out the value of 
# “DisplayName” – Write to the Host console the name of the computer 
# with the application beside it


Foreach ($key in $subkeys) 
{ 
    $exactkey=$key 
    $NewSubKey=$SubBranch+"\\"+$exactkey 
    $ReadUninstall=$registry.OpenSubKey($NewSubKey) 
    $Value=$ReadUninstall.GetValue("DisplayName") 
    $aa= $aa + $computername, $Value
    #write-host $computername, $value
}


# Note – With very little modification (by killing the loop) you could modify 
# this script to query a remote machine for a SPECIFIC application
}
$aa | Sort-Object 
Write-Host " "
pause
