

$pcname = read-host "Enter computername to connect to :"
$CMDline = read-host "Enter CMD line entry :"

   
   
   
    #pause funtion
function Pause ($Message=”Press any key to continue…”)
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey(”NoEcho,IncludeKeyDown”)
Write-Host “”
}

#remote process function
Function New-RemoteProcess {
    Param([string]$computername=$env:computername,
          [string]$cmd=$(Throw "You must enter the full path to the command which will create the process.")
        )
    

    
    
    $ErrorActionPreference="SilentlyContinue"
     
    Trap {
        Write-Warning "There was an error connecting to the remote computer or creating the process"
        Continue
    }    
      
    
    
        
    Write-Host "Connecting to $computername" -ForegroundColor CYAN
    
    [wmiclass]$wmi="\\$computername\root\cimv2:win32_process"
    
    #bail out if the object didnt' get created
    if (!$wmi) {return}
    
    $remote=$wmi.Create($cmd)
    
    if ($remote.returnvalue -eq 0) {
        Write-Host "Successfully launched -  $cmd on $computername with a process id of" $remote.processid -ForegroundColor GREEN
    }
    else {
        Write-Host "Failed to launch -  $cmd on $computername. ReturnValue is" $remote.ReturnValue -ForegroundColor RED
    }
}


#execute cmd
New-RemoteProcess -comp $pcname -cmd $CMDline

pause