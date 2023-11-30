function Ping-Host {
        param (
        [string]$computer = "localhost"
               )
        $results = gwmi -Query "SELECT * FROM Win32_pingstatus WHERE Address = '$computer'"
        If ($results.statuscode -eq 0) {
            Write-Host "$computer"
        } 
        }

        $comps = Get-Content "c:\temp\comps.txt"
foreach ($comp in $comps)
{
 
 Ping-Host $comp
 
 }