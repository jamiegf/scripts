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
$NodeR3 = "\\mvm-race3"
$NodeR4 = "\\mvm-race4"
$NodeI = "\\mvm-inPlay1"
$NodeI2 = "\\mvm-inPlay2"
$NodeI3 = "\\mvm-inPlay3"
$NodeI4 = "\\mvm-inPlay4"
$nodeI5 = "\\mvm-inPlay5"


$logfolder = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily\$yesterday"
#$InplayLogFolder = "C:\inetpub\wwwroot\DriftWood\Logs\MapInplayLogsDaily\$yesterday"
$BackupLogsFolder = "\\mvm-bak\E$\Wager_logs"

$logFolderCSV = "download\csv\$yesterday.csv"
$logFolderLOG = "gaming\StationSports\CSV\$yesterdayUS.miomni.csv.log"
$LogsWebsite = "https://Logs_Casino_bets_314159265358979323846.miomni.com"
$ZipTarget = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily_Zips\LogsCombined_$Yesterday.zip"

New-Item $logfolder -ItemType directory

#New-Item $InplayLogFolder -ItemType directory

#debug
$ProgLog = "c:\temp\dailylogs1.txt"
remove-item $progLog -force
New-Item $ProgLog -ItemType File
$timeStamp = get-date
write-host $timeStamp

###############################################



#atlantisRace
##############
write-host "starting Atlantis Race"
$timeStamp = get-date
"$timeStamp atlantis race start" >> $ProgLog #debug
$atlantisRaceCSV = "$NodeR\c$\Gaming\atlantisRace-Live21\WagerLogs\$yesterdayUS.txt"
$atlantisRaceCSV2 = "$NodeR2\c$\Gaming\atlantisRace-Live21\WagerLogs\$yesterdayUS.txt"
$atlantisRaceCSV3 = "$NodeR\c$\Gaming\Logs\Atlantis-Race-6-0\WagerLogs\$yesterdayUS.txt"
$atlantisRaceCSV4 = "$NodeR2\c$\Gaming\Logs\Atlantis-Race-6-0\WagerLogs\$yesterdayUS.txt"

#create outfile in logs website
$atlantisRaceOutfile = "$logfolder\atlantisRace_$yesterday.txt"
if (!(test-path $atlantisRaceOutfile)) {New-Item $atlantisRaceOutfile -ItemType file}
#create outfile on backup server
$atlantisRaceOutfileBak = "$BackupLogsFolder\atlantisRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\atlantisRace)) {New-Item $BackupLogsFolder\atlantisRace -ItemType directory }
if (!(test-path $atlantisRaceOutfileBak)) {New-Item $atlantisRaceOutfileBak -ItemType file}
#suckup all logs
$atlantisRaceCombined = Get-Content $atlantisRaceCSV
$atlantisRaceCombined = $atlantisRaceCombined + (Get-Content $atlantisRaceCSV2)
$atlantisRaceCombined = $atlantisRaceCombined + (Get-Content $atlantisRaceCSV3)
$atlantisRaceCombined = $atlantisRaceCombined + (Get-Content $atlantisRaceCSV4)
#copy concatanated logs to logs website and backup server
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfile
$atlantisRaceCombined | Out-File -Encoding utf8 $atlantisRaceOutfileBak
#count lines
$atlantisRaceCount = get-content "$logfolder\atlantisRace_$yesterday.txt"  | measure-object -line
$intatlantisRaceCount =  $atlantisRaceCount.lines
$timeStamp = get-date
"$timeStamp atlantis race end" >> $ProgLog #debug


#BoydRace
##############
write-host "starting Boyd Race"
$timeStamp = get-date
"$timeStamp boyd race start" >> $ProgLog #debug

$BoydRaceCSV = "$NodeR\c$\Gaming\BoydRace-Live201\WagerLogs\$yesterdayUS.txt"
$BoydRaceCSV2 = "$NodeR2\c$\Gaming\BoydRace-Live201\WagerLogs\$yesterdayUS.txt"

#create outfile in logs website
$BoydRaceOutfile = "$logfolder\BoydRace_$yesterday.txt"
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
$BoydRaceCount = get-content "$logfolder\BoydRace_$yesterday.txt"  | measure-object -line
$intBoydRaceCount =  $BoydRaceCount.lines

$timeStamp = get-date
"$timeStamp boyd race end" >> $ProgLog #debug



#SouthPointRace
##############
write-host "starting SouthPoint"
$timeStamp = get-date
"$timeStamp southpoint race start" >> $ProgLog #debug
$SouthPointRaceCSV = "$NodeR\c$\Gaming\SouthPointRace-Live314\WagerLogs\$yesterdayUS.txt"
$SouthPointRaceCSV2 = "$NodeR2\c$\Gaming\SouthPointRace-Live314\WagerLogs\$yesterdayUS.txt"
$SouthPointRaceCSV3 = "$NodeR\c$\gaming\Logs\Southpoint-Race-6-0\WagerLogs\$yesterdayUS.txt"
$SouthPointRaceCSV4 = "$NodeR2\c$\gaming\Logs\Southpoint-Race-6-0\WagerLogs\$yesterdayUS.txt"
#$SouthPointRaceCSV2 = "$NodeR2\c$\Gaming\SouthPointRace\WagerLogs\$yesterday.csv"

#create outfile in logs website
$SouthPointRaceOutfile = "$logfolder\SouthPointRace_$yesterday.txt"
if (!(test-path $SouthPointRaceOutfile)) {New-Item $SouthPointRaceOutfile -ItemType file}
#create outfile on backup server
$SouthPointRaceOutfileBak = "$BackupLogsFolder\SouthPointRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\SouthPointRace)) {New-Item $BackupLogsFolder\SouthPointRace -ItemType directory }
if (!(test-path $SouthPointRaceOutfileBak)) {New-Item $SouthPointRaceOutfileBak -ItemType file}
#suckup all logs
$SouthPointRaceCombined = Get-Content $SouthPointRaceCSV
$SouthPointRaceCombined = $SouthPointRaceCombined + (Get-Content $SouthPointRaceCSV2)
$SouthPointRaceCombined = $SouthPointRaceCombined + (Get-Content $SouthPointRaceCSV3)
$SouthPointRaceCombined = $SouthPointRaceCombined + (Get-Content $SouthPointRaceCSV4)
#copy concatanated logs to logs website and backup server
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfile
$SouthPointRaceCombined | Out-File -Encoding utf8 $SouthPointRaceOutfileBak
#count lines
$SouthPointRaceCount = get-content "$logfolder\SouthPointRace_$yesterday.txt" |measure-object -line
$intSouthPointRaceCount =  $SouthPointRaceCount.lines
$timeStamp = get-date
"$timeStamp southpoint race end" >> $ProgLog #debug



#StationRace
##############
write-host "starting Station Race"
$timeStamp = get-date
"$timeStamp station race start" >> $ProgLog #debug
$stationRaceCSV = "$NodeR1\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$yesterdayUS.txt"
$stationRaceCSV2 = "$NodeR2\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$yesterdayUS.txt"
$stationRaceCSV3 = "$NodeR3\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$yesterdayUS.txt"
$stationRaceCSV4 = "$NodeR4\c$\Gaming\Logs\Station-Race-6-0\WagerLogs\$yesterdayUS.txt"
$stationRaceCSV5 = "$NodeR3\c$\Gaming\StationRace-Live313\WagerLogs\$yesterdayUS.txt"
$stationRaceCSV6 = "$NodeR4\c$\Gaming\StationRace-Live313\WagerLogs\$yesterdayUS.txt"
#create outfile in logs website
$StationRaceOutfile = "$logfolder\StationRace_$yesterday.txt"
if (!(test-path $StationRaceOutfile)) {New-Item $StationRaceOutfile -ItemType file}
write-host $StationRaceOutfile
#create outfile on backup server
$StationRaceOutfileBak = "$BackupLogsFolder\StationRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\StationRace)) {New-Item $BackupLogsFolder\StationRace -ItemType directory }
if (!(test-path $StationRaceOutfileBak)) {New-Item $StationRaceOutfileBak -ItemType file}
#suckup all logs
$stationRaceCombined = Get-Content $stationRaceCSV
$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV2)
$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV3)
$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV4)
$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV5)
$stationRaceCombined = $stationRaceCombined + (Get-Content $stationRaceCSV6)
#copy concatanated logs to logs website and backup server
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfile
$stationRaceCombined | Out-File -Encoding utf8 $StationRaceOutfileBak
#count lines
$stationRaceCount = get-content "$logfolder\stationRace_$yesterday.txt"  | measure-object -line
$intStationRaceCount =  $stationRaceCount.lines
$timeStamp = get-date
"$timeStamp station race end" >> $ProgLog #debug


#StationInPLay
#################
write-host "starting Station Inplay"
$timeStamp = get-date
"$timeStamp station inplay start" >> $ProgLog #debug

#Set Wager logs CSV
$stationInplayCSV = "$nodeI\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$yesterdayUS.txt"
$stationInplayCSV2 = "$nodeI2\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$yesterdayUS.txt"
$stationInplayCSV3 = "$nodeI3\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$yesterdayUS.txt"
$stationInplayCSV4 = "$nodeI4\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$yesterdayUS.txt"
$stationInplayCSV5 = "$nodeI5\c$\gaming\Logs\Station-Inplay-6-0\WagerLogs\$yesterdayUS.txt"
write-host $stationInplayCSV5

#create outfile in logs website
$StationInPLayOutfile = "$logfolder\StationInPlay_$yesterday.txt"
if (!(test-path $StationInPLayOutfile)) {New-Item $StationInPlayOutfile -ItemType file}
#create outfile on backup server
$StationInPlayOutfileBak = "$BackupLogsFolder\StationInPlay\$yesterday.csv"
if (!(test-path $BackupLogsFolder\StationInPlay)) {New-Item $BackupLogsFolder\StationInPlay -ItemType directory }
if (!(test-path $StationInPlayOutfileBak)) {New-Item $StationInPlayOutfileBak -ItemType file}
#suckup all logs
$stationInPlayCombined = Get-Content $stationInPlayCSV
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV2)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV3)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV4)
$stationInPlayCombined = $stationInPlayCombined + (Get-Content $stationInPlayCSV5)
#copy concatanated logs to logs website and backup server
$stationInPlayCombined | Out-File -Encoding utf8 $StationInPlayOutfile
$stationInPlayCombined | Out-File -Encoding utf8 $StationInPlayOutfileBak
#count lines
$stationInPlayCount = get-content "$logfolder\stationInPlay_$yesterday.txt"  | measure-object -line
$intStationInPlayCount =  $stationInPlayCount.lines
$timeStamp = get-date
"$timeStamp station inplay end" >> $ProgLog #debug

# Station
##############
write-host "starting Station pregeame"
$timeStamp = get-date
"$timeStamp station start" >> $ProgLog #debug
#WebsiteWager Log Files
$StationCSV = "$Node1\c$\$logFolderLOG"
$stationCSV2 = "$Node2\c$\$logFolderLOG"
$stationCSV3 = "$Node3\c$\$logFolderLOG"

#create outfile in logs website
$stationOutfile = "$logfolder\station_$yesterday.txt"
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
$stationCount = get-content "$logfolder\station_$yesterday.txt"  | measure-object -line
$intStationCount =  $stationCount.lines


$timeStamp = get-date
"$timeStamp station end" >> $ProgLog #debug


# Wynn
##############
write-host "starting Wynn"
$timeStamp = get-date
"$timeStamp wynn start" >> $ProgLog #debug
#WebsiteWager Log Files
$WynnCSV = "$Node1\c$\inetpub\wwwroot\WynnSport-live52\$logfolderCSV"
$WynnCSV2 = "$Node2\c$\inetpub\wwwroot\WynnSport-live52\$logfolderCSV"
$WynnCSV3 = "$Node3\c$\inetpub\wwwroot\WynnSport-live52\$logfolderCSV"

#create outfile in logs website
$WynnOutfile = "$logfolder\Wynn_$yesterday.txt"
if (!(test-path $WynnOutfile)) {New-Item $WynnOutfile -ItemType file}
#create outfile on backup server
$WynnOutfileBak = "$BackupLogsFolder\Wynn\$yesterday.csv"
if (!(test-path $BackupLogsFolder\Wynn)) {New-Item $BackupLogsFolder\Wynn -ItemType directory }
if (!(test-path $WynnOutfileBak)) {New-Item $WynnOutfileBak -ItemType file}
#suckup all logs
$WynnCombined = Get-Content $WynnCSV
$WynnCombined = $WynnCombined + (Get-Content $WynnCSV2)
$WynnCombined = $WynnCombined + (Get-Content $WynnCSV3)
#copy concatanated logs to logs website and backup server
$WynnCombined | Out-File -Encoding utf8 $WynnOutfile
$WynnCombined | Out-File -Encoding utf8 $WynnOutfileBak
#count lines
$WynnCount = get-content "$logfolder\Wynn_$yesterday.txt"  | measure-object -line
$intWynnCount =  $WynnCount.lines
$timeStamp = get-date
"$timeStamp wynn end" >> $ProgLog #debug
#WynnRace
##############
write-host "starting Wynn Race"
"$timeStamp wynn race start" >> $ProgLog #debug

$WynnRaceCSV = "$NodeR\c$\Gaming\WynnRace-Live201\WagerLogs\$yesterdayUS.txt"
$WynnRaceCSV2 = "$NodeR2\c$\Gaming\WynnRace-Live201\WagerLogs\$yesterdayUS.txt"

#create outfile in logs website
$WynnRaceOutfile = "$logfolder\WynnRace_$yesterday.txt"
if (!(test-path $WynnRaceOutfile)) {New-Item $WynnRaceOutfile -ItemType file}
#create outfile on backup server
$WynnRaceOutfileBak = "$BackupLogsFolder\WynnRace\$yesterday.csv"
if (!(test-path $BackupLogsFolder\WynnRace)) {New-Item $BackupLogsFolder\WynnRace -ItemType directory }
if (!(test-path $WynnRaceOutfileBak)) {New-Item $WynnRaceOutfileBak -ItemType file}
#suckup all logs
$WynnRaceCombined = Get-Content $WynnRaceCSV
$WynnRaceCombined = $WynnRaceCombined + (Get-Content $WynnRaceCSV2)
#copy concatanated logs to logs website and backup server
$WynnRaceCombined | Out-File -Encoding utf8 $WynnRaceOutfile
$WynnRaceCombined | Out-File -Encoding utf8 $WynnRaceOutfileBak
#count lines
$WynnRaceCount = get-content "$logfolder\WynnRace_$yesterday.txt"  | measure-object -line
$intWynnRaceCount =  $WynnRaceCount.lines
$timeStamp = get-date
"$timeStamp wynn race end " >> $ProgLog #debug

##################################################################

#Compress Logs and put in zips folder
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

sz a -tzip  $ZipTarget $logfolder
####################################################################
#check for any errors in the CSV files

cd $logfolder

$errormessage = $null
gci $logfolder -Filter *.txt |
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
AtlantisRace            $intAtlantisRaceCount
BoydRace                 $intBoydRaceCount
SouthPointRace      $intSouthPointRaceCount
Station                     $intStationCount
StationInPlay          $intStationInPlayCount
StationRace            $intStationRaceCount
Wynn                      $intWynnCount
WynnRace              $intWynnRaceCount

Map Links
-------------
AtlantisRace	                  - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=atlantisRace
BoydRace                           - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=boydrace 
SouthPoint                        - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=SouthPointRace
Station                              - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=station
StationInPlay                    - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationInPLay
StationRace		         - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationRace
Wynn                                - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=wynn          
WynnRace                         - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=wynnRace   

TXT Links
------------



AtlantisRace	    	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/atlantisRace_$yesterday.txt
BoydRace	  	 - $LogsWebsite/Logs/MapLogsDaily/$yesterday/boydRace_$yesterday.txt
SouthPointRace           - $LogsWebsite/Logs/MapLogsDaily/$yesterday/SouthPointRace_$yesterday.txt
Station                        - $LogsWebsite/Logs/MapLogsDaily/$yesterday/station_$yesterday.txt
StationInPLay	           - $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationInPlay_$yesterday.txt
StationRace	    	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationRace_$yesterday.txt
Wynn     	     	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/wynn_$yesterday.txt
WynnRace     		- $LogsWebsite/Logs/MapLogsDaily/$yesterday/wynnrace_$yesterday.txt


"@



                           $emailAddress = "alert@miomni.com"
                            #$from = "Notifications@miomni.com"
                           $from = "alert@miomni.com"
                            $password = "777RedHound321"
                           # $to = @("logs@miomni.com", "dgtemba@yahoo.co.uk")
                            $to = @("dave.garrity@miomni.com", "jamie.garrow-fisher@miomni.com")
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Live Logs"
                            
                           
"$timeStamp sending email1" >> $ProgLog #debug
 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from
 "$timeStamp sent email1, sending email2" >> $ProgLog #debug
 Send-MailMessage -To $to2 -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from
  "$timeStamp sent email2" >> $ProgLog #debug  

