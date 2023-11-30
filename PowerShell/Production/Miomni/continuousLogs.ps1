#get day or yesterdays date if before 4am
[int]$hour = get-date -format HH
If($hour -lt 4 ){ $day = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') }
Else{$day = (get-date).tostring('MM_dd_yyyy')
}
If($hour -lt 4 ){ $dayUS = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') }
Else{$dayUS = (get-date).tostring('yyyy-MM-dd')
}



$Node1 = "\\mvm-prd1"
$Node2 = "\\mvm-prd2"
$Node3 = "\\mvm-prd3"
$NodeR = "\\mvm-race1"
$NodeR2 = "\\mvm-race2"
$NodeI = "\\mvm-inplay"
$logFolderCSV = "download\csv\$day.csv"
$RaceLogFolderCSV = "Gaming\StationRace\WagerLogs\$day.csv"
$continuousLogs = "$Node1\c$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsContinuous"


#$wynnCSV = "$wwwroot\WynnSports-live40\$logfolderCSV"
#$wynnCSV2 = "$wwwroot\WynnSports-live372\$logfolderCSV"
#$wynnCSV3 = "C:\Gaming\WynnRace\WagerLogs\$day.csv"

if($hour -eq 4) {Remove-Item $continuousLogs\*.*}

# Atlantis
##############
$atlantisCSV = "$Node1\wwwroot\AtlantisSports-live52\$logfolderCSV"
$atlantisCSV2 = "$Node2\wwwroot\AtlantisSports-live52\$logfolderCSV"
$atlantisCSV3 = "$Node3\wwwroot\AtlantisSports-live52\$logfolderCSV"

$atlantisOutfile = "$continuousLogs\atlantis.txt"
if (!(test-path $atlantisOutfile)) {New-Item $atlantisOutfile -ItemType file}
$atlantisCombined = Get-Content $atlantisCSV
$atlantisCombined = $atlantisCombined + (Get-Content $atlantisCSV2)
$atlantisCombined = $atlantisCombined + (Get-Content $atlantisCSV3)
$atlantisCombined | Out-File -Encoding utf8 $atlantisOutfile


# atlantisRace
$atlantisRaceCSV = "$NodeR\C$\Gaming\atlantisRace-Live21\WagerLogs\$dayUS.txt"
$atlantisRaceCSV = "$NodeR\C$\Gaming\atlantisRace-Live21\WagerLogs\$dayUS.txt"
#create outfile in logs website
$atlantisRaceOutfile = "$continuousLogs\atlantisRace.txt"
if (!(test-path $atlantisRaceOutfile)) {New-Item $atlantisRaceOutfile -ItemType file}
#
$atlantisRaceCombined = Get-Content $atlantisRaceCSV
$atlantisRaceCombined = $atlantisRaceCombined + ( Get-Content $atlantisRaceCSV2)
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfile

# Boyd
##############
$BoydCSV = "$Node1\wwwroot\BoydSport-live52\$logfolderCSV"
$BoydCSV2 = "$Node2\wwwroot\BoydSport-live52\$logfolderCSV"
$BoydCSV3 = "$Node3\wwwroot\BoydSport-live52\$logfolderCSV"

$BoydOutfile = "$continuousLogs\Boyd.txt"
if (!(test-path $BoydOutfile)) {New-Item $BoydOutfile -ItemType file}
$BoydCombined = Get-Content $BoydCSV
$BoydCombined = $BoydCombined + (Get-Content $BoydCSV2)
$BoydCombined = $BoydCombined + (Get-Content $BoydCSV3)
$BoydCombined | Out-File -Encoding utf8 $BoydOutfile

# BoydRace
$BoydRaceCSV = "$NodeR\C$\Gaming\BoydRace-Live21\WagerLogs\$dayUS.txt"
$BoydRaceCSV2 = "$NodeR2\C$\Gaming\BoydRace-Live21\WagerLogs\$dayUS.txt"
#create outfile in logs website
$BoydRaceOutfile = "$continuousLogs\BoydRace.txt"
if (!(test-path $BoydRaceOutfile)) {New-Item $BoydRaceOutfile -ItemType file}
#
$BoydRaceCombined = Get-Content $BoydRaceCSV
$BoydRaceCombined = $BoydRaceCombined + ( Get-Content $BoydRaceCSV2)
$BoydRaceCombined | Out-File -Encoding utf8 $BoydRaceOutfile


# GoldenNugget
##############
$GoldenNuggetCSV = "$Node1\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"
$GoldenNuggetCSV2 = "$Node2\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"
$GoldenNuggetCSV3 = "$Node3\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"

$GoldenNuggetOutfile = "$continuousLogs\GoldenNugget.txt"
if (!(test-path $GoldenNuggetOutfile)) {New-Item $GoldenNuggetOutfile -ItemType file}
$GoldenNuggetCombined = Get-Content $GoldenNuggetCSV
$GoldenNuggetCombined = $GoldenNuggetCombined + (Get-Content $GoldenNuggetCSV2)
$GoldenNuggetCombined = $GoldenNuggetCombined + (Get-Content $GoldenNuggetCSV3)
$GoldenNuggetCombined | Out-File -Encoding utf8 $GoldenNuggetOutfile


# SouthPointRace
$SouthPointRaceCSV = "$NodeR\C$\Gaming\SouthPointRace-Live201\WagerLogs\$dayUS.txt"
$SouthPointRaceCSV2 = "$NodeR2\C$\Gaming\SouthPointRace-live201\WagerLogs\$dayUS.txt"
#create outfile in logs website
$SouthPointRaceOutfile = "$continuousLogs\SouthPointRace.txt"
if (!(test-path $SouthPointRaceOutfile)) {New-Item $SouthPointRaceOutfile -ItemType file}
#
$SouthPointRaceCombined = Get-Content $SouthPointRaceCSV
$SouthPointRaceCombined = $SouthPointRaceCombined + ( Get-Content $SouthPointRaceCSV2)
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfile





# StationRace
$StationRaceCSV = "$NodeR\C$\Gaming\StationRace-Live21\WagerLogs\$dayUS.txt"
#$StationRaceCSV2 = "$Node2\C$\Gaming\StationRace\WagerLogs\$day.csv"
#create outfile in logs website
$StationRaceOutfile = "$continuousLogs\StationRace.txt"
if (!(test-path $StationRaceOutfile)) {New-Item $StationRaceOutfile -ItemType file}
#
$stationRaceCombined = Get-Content $stationRaceCSV
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV2)
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfile
write-host " EEEEE $StationRaceCSV"


# Station Inplay
$stationInplayCSV = "$NodeI\c$\gaming\StationInplay-live21\WagerLogs\$dayUS.txt"

$stationInplayOutfile = "$continuousLogs\stationInplay.txt"
if (!(test-path $stationInplayOutfile)) {New-Item $stationInplayOutfile -ItemType file}

$StationInPlayCombined = Get-Content $stationInplayOutfile
#$StationInPLayCombined = $StationInPLayCombined + (get-content $stationInplayOutfile1)

$StationInPLayCombined | out-file $stationInplayOutfile

# caesars
###############
#website logs
$caesarsCSV = "$Node1\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"
$caesarsCSV2 = "$Node2\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"
$caesarsCSV3 = "$Node3\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"

$caesarsOutfile = "$continuousLogs\caesars.txt"
if (!(test-path $caesarsOutfile)) {New-Item $caesarsOutfile -ItemType file}
$caesarsCombined = Get-Content $caesarsCSV
$caesarsCombined = $caesarsCombined + ( Get-Content $caesarsCSV2)
$caesarsCombined = $caesarsCombined + ( Get-Content $caesarsCSV3)
$caesarsCombined | Out-File -Encoding utf8 $caesarsOutfile

# station
###############
#website logs
$stationCSV = "$Node1\C$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"
$stationCSV2 = "$Node2\C$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"
$stationCSV3 = "$Node3\C$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"

$stationOutfile = "$continuousLogs\station.txt"
if (!(test-path $stationOutfile)) {New-Item $stationOutfile -ItemType file}
$stationCombined = Get-Content $stationCSV
$stationCombined = $stationCombined + ( Get-Content $stationCSV2)
$stationCombined = $stationCombined + ( Get-Content $stationCSV3)
$stationCombined | Out-File -Encoding utf8 $stationOutfile

# Treasure
###############
#website logs
$TreasureCSV = "$Node1\wwwroot\treasure-live52\$logfolderCSV"
$TreasureCSV2 = "$Node2\wwwroot\treasure-live52\$logfolderCSV"
$TreasureCSV3 = "$Node3\wwwroot\treasure-live52\$logfolderCSV"

$treasureOutfile = "$continuousLogs\treasure.txt"
if (!(test-path $treasureOutfile)) {New-Item $treasureOutfile -ItemType file}
$treasureCombined = Get-Content $treasureCSV
$treasureCombined = $treasureCombined + ( Get-Content $treasureCSV2)
$treasureCombined = $treasureCombined + ( Get-Content $treasureCSV3)
$treasureCombined | Out-File -Encoding utf8 $treasureOutfile

# westgate
##############
$westgateCSV = "$Node1\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV2 = "$Node2\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV3 = "$Node3\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV4 = "$Node1\wwwroot\WestgateSports-live52\$logfolderCSV"
$westgateCSV5 = "$Node2\wwwroot\WestgateSports-live52\$logfolderCSV"
$westgateCSV6 = "$Node3\wwwroot\WestgateSports-live52\$logfolderCSV"

$westgateOutfile = "$continuousLogs\westgate.txt"
if (!(test-path $westgateOutfile)) {New-Item $westgateOutfile -ItemType file}
$westgateCombined = Get-Content $westgateCSV
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV2)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV3)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV4)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV5)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV6)
$westgateCombined | Out-File -Encoding utf8 $westgateOutfile

# Wynn
<#
$wynnOutfile = "$continuousLogs\wynn.csv"
if (!(test-path $wynnOutfile)) {New-Item $wynnOutfile -ItemType file}
$wynnCombined = Get-Content $wynnCSV
$wynnCombined = $wynnCombined + (Get-Content $wynnCSV2)
$wynnCombined = $wynnCombined + (Get-Content $wynnCSV3)
$wynnCombined | Out-File -encoding utf8 $wynnOutfile
#>

exit