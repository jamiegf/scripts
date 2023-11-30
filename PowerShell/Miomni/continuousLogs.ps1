#get day or yesterdays date if before 4am
[int]$hour = get-date -format HH
If($hour -lt 4 ){ $day = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') }
Else{$day = (get-date).tostring('MM_dd_yyyy')
}



$wwwroot = "C:\inetpub\wwwroot"
$logFolderCSV = "download\csv\$day.csv"
$continuousLogs = "C:\inetpub\wwwroot\DriftWood\Logs\MapLogsContinuous"

$atlantisCSV = "$wwwroot\AtlantisSports-live452\$logfolderCSV"
$atlantisCSV2 = "C:\Gaming\Atlantis\WagerLogs\$day.csv"

$boydCSV = "$wwwroot\boydsports-live452\$logfolderCSV"
$boydCSV2 = "$wwwroot\boydsports-live45\$logfolderCSV"
$boydCSV3 = "C:\Gaming\BoydRace\WagerLogs4.0\$day.csv"
$boydCSV4 = "$wwwroot\BoydRace-live36\Logs\$day.csv"

$goldenNuggetCSV = "$wwwroot\GoldenNuggetSports-live45\$logfolderCSV"

$southPointCSV = "C:\Gaming\SouthPoint\WagerLogs\$day.csv"

$stationCSV = "$wwwroot\stationSports-live453\$logfolderCSV"
$stationCSV2 = "$wwwroot\stationSports-live452\$logfolderCSV"
$stationCSV3 = "C:\Gaming\StationRace\WagerLogs\$day.csv"


$TreasureCSV = "$wwwroot\treasure-live372\$logfolderCSV"

$westgateCSV = "$wwwroot\WestgateSports-live452\$logfolderCSV"

$wynnCSV = "$wwwroot\WynnSports-live40\$logfolderCSV"
$wynnCSV2 = "$wwwroot\WynnSports-live372\$logfolderCSV"
$wynnCSV3 = "C:\Gaming\WynnRace\WagerLogs\$day.csv"

if($hour -eq 4) {Remove-Item $continuousLogs\*.*}

#ATLANTIS
# copy-item "C:\inetpub\wwwroot\atlantis-live35\Download\CSV\%YESTERDAY%.csv" "C:\inetpub\wwwroot\DriftWood\Logs\MapLogsContinous\atlantis.csv"
$AtlantisOutfile = "$continuousLogs\Atlantis.csv"
if (!(test-path $AtlantisOutfile)) {New-Item $AtlantisOutfile -ItemType file}
$AtlantisCombined = Get-Content $AtlantisCSV
$AtlantisCombined = $AtlantisCombined + (Get-Content $AtlantisCSV2)
$AtlantisCombined | Out-File -encoding utf8 $AtlantisOutfile


# Boyd
$BoydOutfile = "$continuousLogs\boyd.csv"
if (!(test-path $BoydOutfile)) {New-Item $BoydOutfile -ItemType file}
$BoydCombined = Get-Content $boydCSV
$BoydCombined = $BoydCombined + (Get-Content $boydCSV2)
$BoydCombined = $BoydCombined + (Get-Content $boydCSV3)
$BoydCombined = $BoydCombined + (Get-Content $boydCSV4)
$boydCombined | Out-File -encoding utf8 $BoydOutfile

#Golden Nugget
$goldenNuggetOutFile = "$continuousLogs\goldennugget.csv"
$goldenNuggetCombined = Get-Content $goldenNuggetCSV
$goldenNuggetCombined | Out-File -Encoding utf8 $goldenNuggetOutFile

# Southpoint
$southpointOutfile = "$continuousLogs\southpoint.csv"
if (!(test-path $southPointOutfile)) {New-Item $southpointOutfile -ItemType file}
$southPointCombined = Get-Content $southPointCSV
$southpointCombined | Out-File -Encoding utf8 $southpointOutfile

# Station
$stationOutfile = "$continuousLogs\station.csv"
if (!(test-path $stationOutfile)) {New-Item $stationOutfile -ItemType file}
$stationCombined = Get-Content $stationCSV
$stationCombined = $stationCombined + (Get-Content $stationCSV2)
$stationCombined = $stationCombined + (Get-Content $stationCSV3)
$stationCombined | Out-File -encoding utf8 $stationOutfile

# Treasure
$treasureOutfile = "$continuousLogs\treasure.csv"
if (!(test-path $treasureOutfile)) {New-Item $treasureOutfile -ItemType file}
$treasureCombined = Get-Content $treasureCSV
$treasureCombined | Out-File -Encoding utf8 $treasureOutfile

# westgate
$westgateOutfile = "$continuousLogs\westgate.csv"
if (!(test-path $westgateOutfile)) {New-Item $westgateOutfile -ItemType file}
$westgateCombined = Get-Content $westgateCSV
$westgateCombined | Out-File -Encoding utf8 $westgateOutfile

# Wynn
$wynnOutfile = "$continuousLogs\wynn.csv"
if (!(test-path $wynnOutfile)) {New-Item $wynnOutfile -ItemType file}
$wynnCombined = Get-Content $wynnCSV
$wynnCombined = $wynnCombined + (Get-Content $wynnCSV2)
$wynnCombined = $wynnCombined + (Get-Content $wynnCSV3)
$wynnCombined | Out-File -encoding utf8 $wynnOutfile