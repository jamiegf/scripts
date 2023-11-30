function Ping-Host {
        param (
        [string]$computer = "localhost"
               )
        $results = gwmi -Query "SELECT * FROM Win32_pingstatus WHERE Address = '$computer'"
        If ($results.statuscode -eq 0) {
            Write-Host "Pingable"
        } Else {
            Write-Host "Not pingable!"
            }
        }
Ping-Host ada
