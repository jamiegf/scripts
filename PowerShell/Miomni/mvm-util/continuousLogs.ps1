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
$NodeR3 = "\\mvm-race3"
$NodeR4 = "\\mvm-race4"
$NodeI = "\\mvm-inplay1"
$NodeI2 = "\\mvm-inplay2"
$NodeI3 = "\\mvm-inplay3"
$NodeI4 = "\\mvm-inplay4"
$logFolderCSV = "download\csv\$day.csv"
$RaceLogFolderCSV = "Gaming\StationRace\WagerLogs\$day.csv"
$continuousLogs = "$Node1\c$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsContinuous"
$logFolderLOG = "gaming\StationSports\CSV\$dayUS.miomni.csv.log"
$logFolderWynn = "gaming\WynnSports\CSV\$dayUS.miomni.csv.log"



if($hour -eq 4) {Remove-Item $continuousLogs\*.*}

# Atlantis Race
##############
# atlantisRace
$atlantisRaceCSV = "$NodeR\c$\Gaming\logs\Atlantis-Race-6-0\WagerLogs\$dayUS.txt"
$atlantisRaceCSV2 = "$NodeR2\c$\Gaming\logs\Atlantis-Race-6-0\WagerLogs\$dayUS.txt"

#create outfile in logs website
$atlantisRaceOutfile = "$continuousLogs\atlantisRace.txt"
if (!(test-path $atlantisRaceOutfile)) {New-Item $atlantisRaceOutfile -ItemType file}
#
$atlantisRaceCombined = Get-Content $atlantisRaceCSV
$atlantisRaceCombined = $atlantisRaceCombined + ( Get-Content $atlantisRaceCSV2)
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfile




# SouthPointRace
#"$timeStamp southpoint race start" >> $ProgLog #debug
$SouthPointRaceCSV = "$NodeR\c$\Gaming\SouthPointRace-Live314\WagerLogs\$dayUS.txt"
$SouthPointRaceCSV2 = "$NodeR2\c$\Gaming\SouthPointRace-Live314\WagerLogs\$dayUS.txt"
$SouthPointRaceCSV3 = "$NodeR\c$\gaming\Logs\Southpoint-Race-6-0\WagerLogs\$dayUS.txt"
$SouthPointRaceCSV4 = "$NodeR2\c$\gaming\Logs\Southpoint-Race-6-0\WagerLogs\$dayUS.txt"

#create outfile in logs website
$SouthPointRaceOutfile = "$continuousLogs\SouthPointRace.txt"
if (!(test-path $SouthPointRaceOutfile)) {New-Item $SouthPointRaceOutfile -ItemType file}
#
$SouthPointRaceCombined = Get-Content $SouthPointRaceCSV
$SouthPointRaceCombined = $SouthPointRaceCombined + ( Get-Content $SouthPointRaceCSV2)
$SouthPointRaceCombined = $SouthPointRaceCombined + ( Get-Content $SouthPointRaceCSV3)
$SouthPointRaceCombined = $SouthPointRaceCombined + ( Get-Content $SouthPointRaceCSV4)
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfile





# StationRace
$stationRaceCSV = "$NodeR1\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$dayUS.txt"
$stationRaceCSV2 = "$NodeR2\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$dayUS.txt"
$stationRaceCSV3 = "$NodeR3\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$dayUS.txt"
$stationRaceCSV4 = "$NodeR4\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$dayUS.txt"
$stationRaceCSV5 = "$NodeR3\c$\Gaming\StationRace-Live313\WagerLogs\$dayUS.txt"
$stationRaceCSV6 = "$NodeR4\c$\Gaming\StationRace-Live313\WagerLogs\$dayUS.txt"
$StationRaceOutfile = "$continuousLogs\StationRace.txt"
if (!(test-path $StationRaceOutfile)) {New-Item $StationRaceOutfile -ItemType file}
#
$stationRaceCombined = Get-Content $stationRaceCSV
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV2)
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV3)
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV4)
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV5)
$stationRaceCombined = $stationRaceCombined + ( Get-Content $stationRaceCSV6)
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfile



# Station Inplay
$stationInplayCSV = "$nodeI\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"
$stationInplayCSV2 = "$nodeI2\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"
$stationInplayCSV3 = "$nodeI3\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"
$stationInplayCSV4 = "$nodeI4\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"
$stationInplayCSV5 = "$nodeI5\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"

$stationInplayOutfile = "$continuousLogs\stationInplay.txt"
if (!(test-path $stationInplayOutfile)) {New-Item $stationInplayOutfile -ItemType file}

#$StationInPlayCombined = Get-Content $stationInplayOutfile
$StationInPlayCombined = Get-Content $stationInPlayCSV
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV2)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV3)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV4)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV5)

$StationInPLayCombined | out-file $stationInplayOutfile



# station
###############
#website logs
$StationCSV = "$Node1\c$\$logFolderLOG"
$stationCSV2 = "$Node2\c$\$logFolderLOG"
$stationCSV3 = "$Node3\c$\$logFolderLOG"

$stationOutfile = "$continuousLogs\station.txt"
if (!(test-path $stationOutfile)) {New-Item $stationOutfile -ItemType file}
$stationCombined = Get-Content $stationCSV
$stationCombined = $stationCombined + ( Get-Content $stationCSV2)
$stationCombined = $stationCombined + ( Get-Content $stationCSV3)
$stationCombined | Out-File -Encoding utf8 $stationOutfile

# Wynn
###############
#website logs
$WynnCSV = "$Node1\c$\$logFolderWynn"
$WynnCSV2 = "$Node2\c$\$logFolderWynn"
$WynnCSV3 = "$Node3\c$\$logFolderWynn"

$wynnOutfile = "$continuousLogs\wynn.txt"
if (!(test-path $wynnnOutfile)) {New-Item $wynnOutfile -ItemType file}
$wynnCombined = Get-Content $wynnCSV
$wynnCombined = $wynnCombined + ( Get-Content $wynnCSV2)
$wynnCombined = $wynnCombined + ( Get-Content $wynnCSV3)
$wynnCombined | Out-File -Encoding utf8 $wynnOutfile

write-host "$nodeI\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$dayUS.txt"
write-host $stationInplayOutfile
#write-host $stationInPlayCombined
write-host $stationInplayCSV2
write-host $atlantisRaceCSV2
write-host $wynnOutfile
exit