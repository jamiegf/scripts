$b = "C:\Users\jgarrowfisher\New Folder\*"
$a = test-path $b
if ($a -eq $true) {
                    Write-Host "file exists"
                    }
if ($a -eq $false) {
                    write-host "File not found!!!!!"
                    exit
                    }
$c = read-host "hello - we r at the end"

