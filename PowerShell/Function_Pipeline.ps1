function ping-host {
    BEGIN {}
    PROCESS {
            $results = gwmi -Query "SELECT * FROM Win32_PingStatus WHERE Address ='$_'"
            if ($results.statuscode -eq 0) {
                Write-Output $_}
                else {
               # Write-Output "cannot ping $_"
               }
             


            }
    END {}

}

"localhost","vega","sdfsadf", "127.0.0.1" |Ping-Host| ForEach-Object {gwmi win32_operatingsystem -ComputerName $_ }