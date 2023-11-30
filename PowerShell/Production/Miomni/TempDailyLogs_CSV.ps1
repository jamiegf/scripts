<#
When adding a new casino. check logs are going to \\mvm-bak\E$\Wager_logs 

#>
$yesterday = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') 
$yesterdayUS = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$Node1 = "\\mvm-prd1"
$Node2 = "\\mvm-prd2"
$Node3 = "\\mvm-prd3"
$NodeR = "\\mvm-race1"
$NodeR2 = "\\mvm-race2"
$NodeI = "\\mvm-inPlay"

$logfolder = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily\$yesterday"
#$InplayLogFolder = "C:\inetpub\wwwroot\DriftWood\Logs\MapInplayLogsDaily\$yesterday"
$BackupLogsFolder = "\\mvm-bak\E$\Wager_logs"

$logFolderCSV = "download\csv\$yesterday.csv"
$LogsWebsite = "https://Logs_Casino_bets_314159265358979323846.miomni.com"
$ZipTarget = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily_Zips\LogsCombined_$Yesterday.zip"

New-Item $logfolder -ItemType directory

#New-Item $InplayLogFolder -ItemType directory

###############################################

# Atlantis
##############
#WebsiteWager Log Files
$atlantisCSV = "$Node1\c$\inetpub\wwwroot\atlantisSports-live52\$logfolderCSV"
$atlantisCSV2 = "$Node2\c$\inetpub\wwwroot\atlantisSports-live52\$logfolderCSV"
$atlantisCSV3 = "$Node3\c$\inetpub\wwwroot\atlantisSports-live52\$logfolderCSV"

#create outfile in logs website
$atlantisOutfile = "$logfolder\atlantis_$yesterday.csv"
if (!(test-path $atlantisOutfile)) {New-Item $atlantisOutfile -ItemType file}
#create outfile on backup server
$atlantisOutfileBak = "$BackupLogsFolder\atlantis\$yesterday.csv"
if (!(test-path $BackupLogsFolder\atlantis)) {New-Item $BackupLogsFolder\atlantis -ItemType directory }
if (!(test-path $atlantisOutfileBak)) {New-Item $atlantisOutfileBak -ItemType file}
#suckup all logs
$atlantisCombined = Get-Content $atlantisCSV
$atlantisCombined = $atlantisCombined + (Get-Content $atlantisCSV2)
$atlantisCombined = $atlantisCombined + (Get-Content $atlantisCSV3)
#copy concatanated logs to logs website and backup server
$atlantisCombined | Out-File -Encoding utf8 $atlantisOutfile
$atlantisCombined | Out-File -Encoding utf8 $atlantisOutfileBak
#count lines
$atlantisCount = get-content "$logfolder\atlantis_$yesterday.csv"  | measure-object -line
$intatlantisCount =  $atlantisCount.lines



#atlantisRace
##############

$atlantisRaceCSV = "$NodeR\c$\Gaming\atlantisRace-Live21\WagerLogs\$yesterdayUS.csv"
$atlantisRaceCSV2 = "$NodeR2\c$\Gaming\atlantisRace-Live21\WagerLogs\$yesterdayUS.csv"

#create outfile in logs website
$atlantisRaceOutfile = "$logfolder\atlantisRace_$yesterday.csv"
if (!(test-path $atlantisRaceOutfile)) {New-Item $atlantisRaceOutfile -ItemType file}
#create outfile on backup server
$atlantisRaceOutfileBak = "$BackupLogsFolder\atlantisRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\atlantisRace)) {New-Item $BackupLogsFolder\atlantisRace -ItemType directory }
if (!(test-path $atlantisRaceOutfileBak)) {New-Item $atlantisRaceOutfileBak -ItemType file}
#suckup all logs
$atlantisRaceCombined = Get-Content $atlantisRaceCSV
$atlantisRaceCombined = $atlantisRaceCombined + (Get-Content $atlantisRaceCSV2)
#copy concatanated logs to logs website and backup server
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfile
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfileBak
#count lines
$atlantisRaceCount = get-content "$logfolder\atlantisRace_$yesterday.csv"  | measure-object -line
$intatlantisRaceCount =  $atlantisRaceCount.lines

# Boyd
##############

#WebsiteWager Log Files
$BoydCSV = "$Node1\c$\inetpub\wwwroot\BoydSport-live52\$logfolderCSV"
$BoydCSV2 = "$Node2\c$\inetpub\wwwroot\BoydSport-live52\$logfolderCSV"
$BoydCSV3 = "$Node3\c$\inetpub\wwwroot\BoydSport-live52\$logfolderCSV"

#create outfile in logs website
$BoydOutfile = "$logfolder\Boyd_$yesterday.csv"
if (!(test-path $BoydOutfile)) {New-Item $BoydOutfile -ItemType file}
#create outfile on backup server
$BoydOutfileBak = "$BackupLogsFolder\Boyd\$yesterday.csv"
if (!(test-path $BackupLogsFolder\Boyd)) {New-Item $BackupLogsFolder\Boyd -ItemType directory }
if (!(test-path $BoydOutfileBak)) {New-Item $BoydOutfileBak -ItemType file}
#suckup all logs
$BoydCombined = Get-Content $BoydCSV
$BoydCombined = $BoydCombined + (Get-Content $BoydCSV2)
$BoydCombined = $BoydCombined + (Get-Content $BoydCSV3)
#copy concatanated logs to logs website and backup server
$BoydCombined | Out-File -Encoding utf8 $BoydOutfile
$BoydCombined | Out-File -Encoding utf8 $BoydOutfileBak
#count lines
$BoydCount = get-content "$logfolder\Boyd_$yesterday.csv"  | measure-object -line
$intBoydCount =  $BoydCount.lines


#BoydRace
##############

$BoydRaceCSV = "$NodeR\c$\Gaming\BoydRace-Live201\WagerLogs\$yesterdayUS.csv"
$BoydRaceCSV2 = "$NodeR2\c$\Gaming\BoydRace-Live201\WagerLogs\$yesterdayUS.csv"

#create outfile in logs website
$BoydRaceOutfile = "$logfolder\BoydRace_$yesterday.csv"
if (!(test-path $BoydRaceOutfile)) {New-Item $BoydRaceOutfile -ItemType file}
#create outfile on backup server
$BoydRaceOutfileBak = "$BackupLogsFolder\BoydRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\BoydRace)) {New-Item $BackupLogsFolder\BoydRace -ItemType directory }
if (!(test-path $BoydRaceOutfileBak)) {New-Item $BoydRaceOutfileBak -ItemType file}
#suckup all logs
$BoydRaceCombined = Get-Content $BoydRaceCSV
$BoydRaceCombined = $BoydRaceCombined + (Get-Content $BoydRaceCSV2)
#copy concatanated logs to logs website and backup server
$BoydRaceCombined | Out-File -Encoding utf8 $BoydRaceOutfile
$BoydRaceCombined | Out-File -Encoding utf8 $BoydRaceOutfileBak
#count lines
$BoydRaceCount = get-content "$logfolder\BoydRace_$yesterday.csv"  | measure-object -line
$intBoydRaceCount =  $BoydRaceCount.lines



#SouthPointRace
##############

$SouthPointRaceCSV = "$NodeR\c$\Gaming\SouthPointRace-Live201\WagerLogs\$yesterdayUS.csv"
$SouthPointRaceCSV2 = "$NodeR2\c$\Gaming\SouthPointRace-Live201\WagerLogs\$yesterdayUS.csv"
#$SouthPointRaceCSV2 = "$NodeR2\c$\Gaming\SouthPointRace\WagerLogs\$yesterday.csv"

#create outfile in logs website
$SouthPointRaceOutfile = "$logfolder\SouthPointRace_$yesterday.csv"
if (!(test-path $SouthPointRaceOutfile)) {New-Item $SouthPointRaceOutfile -ItemType file}
#create outfile on backup server
$SouthPointRaceOutfileBak = "$BackupLogsFolder\SouthPointRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\SouthPointRace)) {New-Item $BackupLogsFolder\SouthPointRace -ItemType directory }
if (!(test-path $SouthPointRaceOutfileBak)) {New-Item $SouthPointRaceOutfileBak -ItemType file}
#suckup all logs
$SouthPointRaceCombined = Get-Content $SouthPointRaceCSV
$SouthPointRaceCombined = $SouthPointRaceCombined + (Get-Content $SouthPointRaceCSV2)
#copy concatanated logs to logs website and backup server
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfile
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfileBak
#count lines
$SouthPointRaceCount = get-content "$logfolder\SouthPointRace_$yesterday.csv" |measure-object -line
$intSouthPointRaceCount =  $SouthPointRaceCount.lines

# GoldenNugget
##############
#WebsiteWager Log Files
$GoldenNuggetCSV = "$Node1\c$\inetpub\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"
$GoldenNuggetCSV2 = "$Node2\c$\inetpub\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"
$GoldenNuggetCSV3 = "$Node3\c$\inetpub\wwwroot\GoldenNuggetSports-live52\$logfolderCSV"

#create outfile in logs website
$GoldenNuggetOutfile = "$logfolder\GoldenNugget_$yesterday.csv"
if (!(test-path $GoldenNuggetOutfile)) {New-Item $GoldenNuggetOutfile -ItemType file}
#create outfile on backup server
$GoldenNuggetOutfileBak = "$BackupLogsFolder\GoldenNugget\$yesterday.csv"
if (!(test-path $BackupLogsFolder\GoldenNugget)) {New-Item $BackupLogsFolder\GoldenNugget -ItemType directory }
if (!(test-path $GoldenNuggetOutfileBak)) {New-Item $GoldenNuggetOutfileBak -ItemType file}
#suckup all logs
$GoldenNuggetCombined = Get-Content $GoldenNuggetCSV
$GoldenNuggetCombined = $GoldenNuggetCombined + (Get-Content $GoldenNuggetCSV2)
$GoldenNuggetCombined = $GoldenNuggetCombined + (Get-Content $GoldenNuggetCSV3)
#copy concatanated logs to logs website and backup server
$GoldenNuggetCombined | Out-File -Encoding utf8 $GoldenNuggetOutfile
$GoldenNuggetCombined | Out-File -Encoding utf8 $GoldenNuggetOutfileBak
#count lines
$GoldenNuggetCount = get-content "$logfolder\GoldenNugget_$yesterday.csv"  | measure-object -line
$intGoldenNuggetCount =  $GoldenNuggetCount.lines

#StationRace
##############

$stationRaceCSV = "$NodeR\c$\Gaming\StationRace-Live21\WagerLogs\$yesterdayUS.csv"
#$stationRaceCSV2 = "$Node2\c$\Gaming\StationRace\WagerLogs\$yesterday.csv"

#create outfile in logs website
$StationRaceOutfile = "$logfolder\StationRace_$yesterday.csv"
if (!(test-path $StationRaceOutfile)) {New-Item $StationRaceOutfile -ItemType file}
#create outfile on backup server
$StationRaceOutfileBak = "$BackupLogsFolder\StationRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\StationRace)) {New-Item $BackupLogsFolder\StationRace -ItemType directory }
if (!(test-path $StationRaceOutfileBak)) {New-Item $StationRaceOutfileBak -ItemType file}
#suckup all logs
$stationRaceCombined = Get-Content $stationRaceCSV
#$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV2)
#copy concatanated logs to logs website and backup server
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfile
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfileBak
#count lines
$stationRaceCount = get-content "$logfolder\stationRace_$yesterday.csv"  | measure-object -line
$intStationRaceCount =  $stationRaceCount.lines


#1111111

#caesarsinplay
#################

#Set Wager logs CSV
$caesarsinplayCSV = "$nodeI\c$\Gaming\caesarsinplay-live21\WagerLogs\$yesterdayUS.csv"
#$caesarsinplayCSV2 = "$node2\c$\Gaming\caesarsinplay\WagerLogs\$yesterday.csv"


#create outfile in logs website
$caesarsinplayOutfile = "$logfolder\caesarsinplay_$yesterday.csv"
if (!(test-path $caesarsinplayOutfile)) {New-Item $caesarsinplayOutfile -ItemType file}
#create outfile on backup server
$caesarsinplayOutfileBak = "$BackupLogsFolder\caesarsinplay\$yesterday.csv"
if (!(test-path $BackupLogsFolder\caesarsinplay)) {New-Item $BackupLogsFolder\caesarsinplay -ItemType directory }
if (!(test-path $caesarsinplayOutfileBak)) {New-Item $caesarsinplayOutfileBak -ItemType file}
#suckup all logs
$caesarsinplayCombined = Get-Content $caesarsinplayCSV
#$caesarsinplayCombined = $caesarsinplayCombined + (Get-Content $caesarsinplayCSV2)
#copy concatanated logs to logs website and backup server
$caesarsinplayCombined | Out-File -Encoding utf8 $caesarsinplayOutfile
$caesarsinplayCombined | Out-File -Encoding utf8 $caesarsinplayOutfileBak
#count lines
$caesarsinplayCount = get-content "$logfolder\caesarsinplay_$yesterday.csv"  | measure-object -line
$intcaesarsinplayCount =  $caesarsinplayCount.lines


# Caesars
##############
#WebsiteWager Log Files
$CaesarsCSV = "$Node1\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"
$CaesarsCSV2 = "$Node2\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"
$CaesarsCSV3 = "$Node3\c$\inetpub\wwwroot\CaesarsSports-live52\$logfolderCSV"

#create outfile in logs website
$caesarsOutfile = "$logfolder\caesars_$yesterday.csv"
if (!(test-path $caesarsOutfile)) {New-Item $caesarsOutfile -ItemType file}
#create outfile on backup server
$caesarsOutfileBak = "$BackupLogsFolder\caesars\$yesterday.csv"
if (!(test-path $BackupLogsFolder\caesars)) {New-Item $BackupLogsFolder\caesars -ItemType directory }
if (!(test-path $caesarsOutfileBak)) {New-Item $caesarsOutfileBak -ItemType file}
#suckup all logs
$caesarsCombined = Get-Content $caesarsCSV
$caesarsCombined = $caesarsCombined + (Get-Content $caesarsCSV2)
$caesarsCombined = $caesarsCombined + (Get-Content $caesarsCSV3)
#copy concatanated logs to logs website and backup server
$caesarsCombined | Out-File -Encoding utf8 $caesarsOutfile
$caesarsCombined | Out-File -Encoding utf8 $caesarsOutfileBak
#count lines
$caesarsCount = get-content "$logfolder\caesars_$yesterday.csv"  | measure-object -line
$intcaesarsCount =  $caesarsCount.lines



#StationInPLay
#################

#Set Wager logs CSV
$stationInplayCSV = "$nodeI\c$\Gaming\StationInplay-live21\WagerLogs\$yesterdayUS.csv"
#$stationInplayCSV2 = "$node2\c$\Gaming\StationInplay\WagerLogs\$yesterday.csv"


#create outfile in logs website
$StationInPLayOutfile = "$logfolder\StationInPlay_$yesterday.csv"
if (!(test-path $StationInPLayOutfile)) {New-Item $StationInPlayOutfile -ItemType file}
#create outfile on backup server
$StationInPlayOutfileBak = "$BackupLogsFolder\StationInPlay\$yesterday.csv"
if (!(test-path $BackupLogsFolder\StationInPlay)) {New-Item $BackupLogsFolder\StationInPlay -ItemType directory }
if (!(test-path $StationInPlayOutfileBak)) {New-Item $StationInPlayOutfileBak -ItemType file}
#suckup all logs
$stationInPlayCombined = Get-Content $stationInPlayCSV
#$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV2)
#copy concatanated logs to logs website and backup server
$stationInPlayCombined | Out-File -Encoding utf8 $StationInPlayOutfile
$stationInPlayCombined | Out-File -Encoding utf8 $StationInPlayOutfileBak
#count lines
$stationInPlayCount = get-content "$logfolder\stationInPlay_$yesterday.csv"  | measure-object -line
$intStationInPlayCount =  $stationInPlayCount.lines


# Station
##############
#WebsiteWager Log Files
$StationCSV = "$Node1\c$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"
$stationCSV2 = "$Node2\c$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"
$stationCSV3 = "$Node3\c$\inetpub\wwwroot\stationSport-live52\$logfolderCSV"

#create outfile in logs website
$stationOutfile = "$logfolder\station_$yesterday.csv"
if (!(test-path $stationOutfile)) {New-Item $stationOutfile -ItemType file}
#create outfile on backup server
$stationOutfileBak = "$BackupLogsFolder\station\$yesterday.csv"
if (!(test-path $BackupLogsFolder\station)) {New-Item $BackupLogsFolder\station -ItemType directory }
if (!(test-path $stationOutfileBak)) {New-Item $stationOutfileBak -ItemType file}
#suckup all logs
$stationCombined = Get-Content $stationCSV
$stationCombined = $stationCombined + (Get-Content $stationCSV2)
$stationCombined = $stationCombined + (Get-Content $stationCSV3)
#copy concatanated logs to logs website and backup server
$stationCombined | Out-File -Encoding utf8 $stationOutfile
$stationCombined | Out-File -Encoding utf8 $stationOutfileBak
#count lines
$stationCount = get-content "$logfolder\station_$yesterday.csv"  | measure-object -line
$intStationCount =  $stationCount.lines


# Treasure
##############
#WebsiteWager Log Files
$TreasureCSV = "$Node1\C$\inetpub\wwwroot\treasure-live372\$logfolderCSV"
$TreasureCSV2 = "$Node2\C$\inetpub\wwwroot\treasure-live372\$logfolderCSV"
$TreasureCSV3 = "$Node3\C$\inetpub\wwwroot\treasure-live372\$logfolderCSV"

#create outfile in logs website
$treasureOutfile = "$logfolder\treasure_$yesterday.csv"
if (!(test-path $treasureOutfile)) {New-Item $treasureOutfile -ItemType file}
#create outfile on backup server
$treasureOutfileBak = "$BackupLogsFolder\Treasure\$yesterday.csv"
if (!(test-path $BackupLogsFolder\Treasure)) {New-Item $BackupLogsFolder\Treasure -ItemType directory }
if (!(test-path $treasureOutfileBak)) {New-Item $treasureOutfileBak -ItemType file}
#suckup all logs
$treasureCombined = Get-Content $treasureCSV
$treasureCombined = $treasureCombined + (Get-Content $treasureCSV2)
$treasureCombined = $treasureCombined + (Get-Content $treasureCSV3)
#copy concatanated logs to logs website and backup server
$treasureCombined | Out-File -Encoding utf8 $treasureOutfile
$treasureCombined | Out-File -Encoding utf8 $treasureOutfileBak
#count lines
$treasureCount = get-content "$logfolder\treasure_$yesterday.csv"  | measure-object -line
$intTreasureCount =  $treasureCount.lines

# westgate
##############
#Website log files
$westgateCSV = "$Node1\C$\inetpub\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV2 = "$Node2\C$\inetpub\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV3 = "$Node3\C$\inetpub\wwwroot\WestgateSports-live452\$logfolderCSV"
$westgateCSV4 = "$Node1\C$\inetpub\wwwroot\WestgateSports-live52\$logfolderCSV"
$westgateCSV5 = "$Node2\C$\inetpub\wwwroot\WestgateSports-live52\$logfolderCSV"
$westgateCSV6 = "$Node3\C$\inetpub\wwwroot\WestgateSports-live52\$logfolderCSV"
#create outfile in logs website
$westgateOutfile = "$logfolder\westgate_$yesterday.csv"
if (!(test-path $westgateOutfile)) {New-Item $westgateOutfile -ItemType file}
#create outfile on backup server
$westgateOutfileBak = "$BackupLogsFolder\Westgate\$yesterday.csv"
if (!(test-path $BackupLogsFolder\Westgate)) {New-Item $BackupLogsFolder\Westgate -ItemType directory }
if (!(test-path $westgateOutfileBak)) {New-Item $westgateOutfileBak -ItemType file}
#suckup all logs
$westgateCombined = Get-Content $westgateCSV
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV2)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV3)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV4)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV5)
$westgateCombined = $westgateCombined + (Get-Content $westgateCSV6)
#copy concatanated logs to logs website and backup server
$westgateCombined | Out-File -Encoding utf8 $westgateOutfile
$westgateCombined | Out-File -Encoding utf8 $westgateOutfileBak

#count
$westgateCount = get-content "$logfolder\westgate_$yesterday.csv"  | measure-object -line
$intwestgateCount =  $westgateCount.lines


##################################################################

#Compress Logs and put in zips folder
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

sz a -tzip  $ZipTarget $logfolder
####################################################################
#check for any errors in the CSV files

cd $logfolder

$errormessage = $null
gci $logfolder -Filter *.csv |
ForEach-Object {
    $CSVLOG = $_.Name
    
        Import-Csv $CSVLOG | Foreach-Object { 
                #check for blank cells or too few characters
                foreach ($property in $_.PSObject.Properties)
                    {
                    $count = $count + 1
                    $str = $property.value
                    if ($str.length -eq 0) {$errorMessage = $errormessage +  " `r `n  Error! $CSVLOG contains a BLANK cell"}
                    elseif ($str.length -lt 3) {$errormessage = $errormessage + "`r `n  Error! Please check $CSVLOG : Too few characters: $str"}
         
                    } 

            }
    
    }
  if (!$errormessage) {$errormessage =  "Results: No errors found in Log Files :)"}


#Email Body for Daily
$emailBody = @"

$errorMessage

Log Count
-------------
Atlantis                    $intAtlantisCount
AtlantisRace            $intAtlantisRaceCount
Boyd                         $intBoydCount
BoydRace                $intBoydRaceCount
Caesars                    $intCaesarsCount
CaesarsInPLay          $intCaesarsInPLayCount
GoldenNugget        $intGoldenNuggetCount
SouthPointRace      $intSouthPointRaceCount
Station                     $intStationCount
StationInPlay          $intStationInPlayCount
StationRace            $intStationRaceCount
Treasure                 $intTreasureCount
Westgate               $intWestgateCount

Map Links
-------------
Atlantis                              - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=atlantis
AtlantisRace	              - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=atlantisRace
Boyd                                   - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=boyd
BoydRace                           - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=boydrace 
Caesars                              - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=caesars
CaesarsInPlay                   - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=caesarsInPLay
Golden Nugget                 - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=GoldenNugget
SouthPoint                        - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=SouthPointRace
Station                               - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=station
StationInPlay                    - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationInPLay
StationRace		- $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationRace
Treasure	     	- $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=treasure
Westgate		- $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=westgate




TXT Links
------------


Atlantis                              - $LogsWebsite/Logs/MapLogsDaily/$yesterday/atlantis_$yesterday.csv
AtlantisRace		- $LogsWebsite/Logs/MapLogsDaily/$yesterday/atlantisRace_$yesterday.csv
Boyd                                  - $LogsWebsite/Logs/MapLogsDaily/$yesterday/boyd_$yesterday.csv
BoydRace	  	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/boydRace_$yesterday.csv
Caesars                              - $LogsWebsite/Logs/MapLogsDaily/$yesterday/caesars_$yesterday.csv
CaesarsInPLay	               - $LogsWebsite/Logs/MapLogsDaily/$yesterday/CaesarsInPlay_$yesterday.csv
GoldenNugget                  - $LogsWebsite/Logs/MapLogsDaily/$yesterday/goldenNugget_$yesterday.csv
SouthPointRace                - $LogsWebsite/Logs/MapLogsDaily/$yesterday/SouthPointRace_$yesterday.csv
Station                               - $LogsWebsite/Logs/MapLogsDaily/$yesterday/station_$yesterday.csv
StationInPLay	               - $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationInPlay_$yesterday.csv
StationRace		- $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationRace_$yesterday.csv
Treasure		- $LogsWebsite/Logs/MapLogsDaily/$yesterday/treasure_$yesterday.csv
Westgate		- $LogsWebsite/Logs/MapLogsDaily/$yesterday/westgate_$yesterday.csv



"@



                            $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                            $password = "777RedHound321"
                            $to = "logs@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Live Logs 2 "
                            
                           

 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from


