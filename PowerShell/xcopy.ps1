
$source = "H:\test\testenv1"
$dest = "H:\test\testenv2"
xcopy $source $dest /e /c /r /i /k /y /o
#comparison checks
$a = Get-ChildItem $source -Recurse
$b = Get-ChildItem $dest -Recurse
$results = Compare-Object $a $b
if (!$results) {Remove-Item $source\* -recurse -Force}
else {write-host "**** Mismatch!! ****** "
$results | fl *}

 