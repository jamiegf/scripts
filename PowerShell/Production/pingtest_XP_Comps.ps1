Add-PSSnapin quest.activeroles.admanagement

$a = Get-QADComputer | where {$_.operatingsystem -like "*xp*"}
$a | ForEach-Object {
                    $b = Test-Connection $_.name
                    if ($b -ne $null) {out-file -filepath c:\winxp.txt -append -inputobject $_.name}
                    }