

$exit = 0

do { write-host "hello"
$a = Read-Host "what to do?"
if ($a -eq "a") { $exit = 1}
if ($a -eq "b") {$exit = 2}
write-host ($exit)




}
until ( $exit -eq 1)