function ping-host {
    BEGIN {}
    PROCESS {
            $results = gwmi -Query "SELECT * FROM Win32_PingStatus WHERE Address ='$_'"

            $obj = New-Object Psobject
            $obj | Add-Member NoteProperty Computer $_
            $obj | Add-Member NoteProperty ResponseTime ($results.responsetime)
            $obj | Add-Member NoteProperty IPAddress ($results.protocoladdress)


                if ($results.statuscode -eq 0) {
                    $obj | Add-Member NoteProperty Responding $True
                  }else {
                    $obj | Add-Member NoteProperty Responding $false
                  }
             
             Write-Output $obj

            }
    END {}

}

"localhost","vega","sdfsadf", "127.0.0.1" |Ping-Host | sort responsetime 