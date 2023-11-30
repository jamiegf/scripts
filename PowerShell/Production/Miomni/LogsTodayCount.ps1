<#
When adding a new casino. check logs are going to \\mvm-bak\E$\Wager_logs 

#>
$today = get-date -format yyyy-MM-dd
#yesterday:
$today = ((get-date).adddays(-1)).tostring('yyyy-MM-dd')

$ErrorActionPreference= 'silentlycontinue'

write-host "Today's logs so far "
write-host "*******************"
write-host ""



#########################################
#Atlantis Race
#########################################



#suckup all logs
$AtlantisRaceLogs = get-content "D:\LogShare\Race\$today\*\Gaming\Atlantis-Race-6-0\WagerLogs\$today.txt"
$AtlantisRaceLogscount = $AtlantisRaceLogs.count
write-host "AtlantisRace Logs :  $AtlantisRaceLogscount"



#########################################
#Southpoint Race
#########################################




#suckup all logs
$SouthpointRaceLogs = get-content "D:\LogShare\Race\$today\*\Gaming\Southpoint-Race-6-0\WagerLogs\$today.txt"
$SouthpointRaceLogscount = $SouthpointRaceLogs.count
write-host "SouthpointRace Logs :  $SouthpointRaceLogscount"



###############################################
# StationSports
##############





#suckup all logs
$stationSportsLogs = get-content "d:\LogShare\Sports\$today\*\Gaming\station-Sports-3-0\CSV\$today.miomni.csv.log"
$stationSportsLogscount = $stationSportsLogs.count
write-host "StationSports Logs :  $stationSportsLogscount"


#
###############################################
#Station Inplay


#suckup all logs
$stationInplayLogs = get-content "d:\LogShare\Inplay\$today\*\Gaming\Station-Inplay-6-0\WagerLogs\$today.txt"
$stationInplayLogscount = $stationInplayLogs.count
write-host "StationInplay Logs :  $stationInplayLogscount"

#############################################


#########################################
#Station Race
#########################################



#suckup all logs
$StationRaceLogs = get-content "d:\LogShare\Race\$today\*\Gaming\Station-Race-6-0\WagerLogs\$today.txt"
$StationRaceLogscount = $StationRaceLogs.count
write-host "StationRace Logs :  $StationRaceLogscount"


# Wynn
##############




#suckup all logs
$wynnSportsLogs = get-content "d:\LogShare\Sports\$today\*\Gaming\WynnSports\CSV\$today.miomni.csv.log"
$WynnSportsLogscount = $WynnSportsLogs.count
write-host "WynnSports Logs :  $WynnSportsLogscount"


#########################################
#Wynn Race
#########################################



#suckup all logs
$WynnRaceLogs = get-content "d:\LogShare\Race\$today\*\Gaming\Wynn-Race-6-0\WagerLogs\$today.txt"
$WynnRaceLogscount = $WynnRaceLogs.count
write-host "WynnRace Logs :  $WynnRaceLogscount"
