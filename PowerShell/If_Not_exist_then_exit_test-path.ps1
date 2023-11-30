$b = "C:\Users\dededef"
$a = test-path $b
[int]$retries = 6
[int]$c = 0
$continue = $false
do{
if ($a -eq $true) {
                    Write-Host "file exists"
                    $continue = $true
                    }
if ($a -eq $false) {
                    write-host "File not found!!!!!"
                    sleep 2
                    $c++
                    If ($c -gt $retries){write-host "exiting" ;exit}
                    }
  }
  until ($continue -eq $true)


